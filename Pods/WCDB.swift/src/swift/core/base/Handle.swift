/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation
import WCDB_Private

public final class Handle {
    private let recyclableHandle: RecyclableCPPHandle
    private lazy var recycleMainStatement = {
        ObjectBridge.createRecyclableCPPObject(WCDBHandleGetMainStatement(self.cppHandle))
    }()

    internal let cppHandle: CPPHandle

    internal let database: Database

    internal init(withCPPHandle cppHandle: CPPHandle, database: Database) {
        self.recyclableHandle = ObjectBridge.createRecyclableCPPObject(cppHandle)
        self.cppHandle = cppHandle
        self.database = database
    }

    internal func getError() -> WCDBError {
        let cppError = WCDBHandleGetError(cppHandle)
        return ErrorBridge.getErrorFrom(cppError: cppError)
    }

    /// Execute a statement directly.
    ///
    /// - Parameter statement: the statement to execute.
    /// - Throws: `Error`
    public func exec(_ statement: Statement) throws {
        let executed = withExtendedLifetime(statement) {
            WCDBHandleExecute(cppHandle, $0.rawCPPObj)
        }
        if !executed {
            let cppError = WCDBHandleGetError(cppHandle)
            throw ErrorBridge.getErrorFrom(cppError: cppError)
        }
    }

    /// Use `sqlite3_prepare` internally to prepare a new statement,
    /// and wrap the `sqlite3_stmt` generated by `sqlite3_prepare` into `PreparedStatement` to return.
    ///
    /// If the statement has been prepared by this method before, and you have not used `-[WCTHandle finalizeAllStatements]` to finalize it,
    /// then you can use this method to regain the previously generated `sqlite3_stmt`.
    ///
    /// This method is designed for the situation where you need to use multiple statements at the same time to do complex database operations.
    /// You can prepare a new statement without finalizing the previous statements, so that you can save the time of analyzing SQL syntax.
    ///
    /// If you only need to use one statement, or you no longer need to use the previous statements when you use a new statement,
    /// it is recommended to use `exec(_:)` or `prepare(_:)`.
    ///
    /// - Parameter statement: the statement to prepare.
    /// - Throws: `Error`
    public func getOrCreatePreparedStatement(with statement: Statement) throws -> PreparedStatement {
        let cppHandleStatement = withExtendedLifetime(statement) { WCDBHandleGetOrCreatePreparedStatement(cppHandle, $0.rawCPPObj)
        }
        let preparedStatement = PreparedStatement(with: cppHandleStatement)
        if !WCDBHandleStatementCheckPrepared(cppHandleStatement) {
            throw getError()
        }
        return preparedStatement
    }

    /// Use `sqlite3_finalize` to finalize all `sqlite3_stmt` generate by current handle.
    public func finalizeAllStatement() {
        WCDBHandleFinalizeStatements(cppHandle)
    }

    /// The wrapper of `sqlite3_changes`.
    public var changes: Int {
        return Int(WCDBHandleGetChange(cppHandle))
    }

    /// The wrapper of `sqlite3_total_changes`.
    public var totalChanges: Int {
        return Int(WCDBHandleGetTotalChange(cppHandle))
    }

    /// The wrapper of `sqlite3_stmt_readonly`.
    public var lastInsertedRowID: Int64 {
        return WCDBHandleGetLastInsertedRowID(cppHandle)
    }

    public final class CancellatiionSignal: @unchecked Sendable {
        private let m_signal: Recyclable<CPPCancellationSignal>
        public init() {
            m_signal = ObjectBridge.createRecyclableCPPObject(WCDBCancellationSignalCreate())
        }

        /// Cancel all operations of the attached handle.
        public func cancel() {
            WCDBCancellationSignalCancel(m_signal.raw)
        }

        internal func getInnerSignal() -> CPPCancellationSignal {
            return m_signal.raw
        }
    }

    /// The wrapper of `sqlite3_progress_handler`.
    ///
    /// You can asynchronously cancel all operations on the current handle through `CancellationSignal`.
    ///
    ///     let signal = CancellatiionSignal()
    ///     DispatchQueue(label: "test").async {
    ///         let handle = database.getHandle()
    ///         handle.attach(cancellationSignal: signal)
    ///
    ///         // Do some time-consuming database operations.
    ///
    ///         handle.detachCancellationSignal()
    ///     }
    ///     signal.cancel()
    ///
    /// Note that you can use `CancellationSignal` in multiple threads,
    /// but you can only use the current handle in the thread that you got it.
    public func attach(cancellationSignal: CancellatiionSignal) {
        WCDBHandleAttachCancellationSignal(cppHandle, cancellationSignal.getInnerSignal())
    }

    /// Detach the attached `CancellationSignal`.
    /// `CancellationSignal` can be automatically detached when the current handle deconstruct.
    public func detachCancellationSignal() {
        WCDBHandleDettachCancellationSignal(cppHandle)
    }
}

public protocol HandleRepresentable {

    func getHandle(writeHint: Bool) throws -> Handle
    func getDatabase() -> Database
}

extension Handle: HandleRepresentable {
    public func getHandle(writeHint: Bool) throws -> Handle {
        return self
    }

    public func getDatabase() -> Database {
        return database
    }
}

extension Handle: RawStatementmentRepresentable {
    public func finalizeWhenError() -> Bool {
        return true
    }

    public func getRawStatement() -> CPPHandleStatement {
        return recycleMainStatement.raw
    }

    /// The wrapper of `sqlite3_prepare`
    ///
    /// - Throws: `Error`
    public func prepare(_ statement: Statement) throws {
        let succeed = withExtendedLifetime(statement) {
            WCDBHandleStatementPrepare(getRawStatement(), $0.rawCPPObj)
        }
        if !succeed {
            let cppError = WCDBHandleStatementGetError(getRawStatement())
            throw ErrorBridge.getErrorFrom(cppError: cppError)
        }
    }

    /// Check if current statement is prepared
    public var isPrepared: Bool {
        WCDBHandleStatementCheckPrepared(getRawStatement())
    }
}

extension Handle: StatementInterface {}

extension Handle: InsertChainCallInterface {}
extension Handle: UpdateChainCallInterface {}
extension Handle: DeleteChainCallInterface {}
extension Handle: RowSelectChainCallInterface {}
extension Handle: SelectChainCallInterface {}
extension Handle: MultiSelectChainCallInterface {}

extension Handle: InsertInterface {}
extension Handle: UpdateInterface {}
extension Handle: DeleteInterface {}
extension Handle: RowSelectInterface {}
extension Handle: SelectInterface {}
extension Handle: StatementSelectInterface {}
extension Handle: TableInterface {}
extension Handle: TransactionInterface {}
