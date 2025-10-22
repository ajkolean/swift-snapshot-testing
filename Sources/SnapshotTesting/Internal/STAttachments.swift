import Foundation

#if !os(Linux) && !os(Android) && !os(Windows) && canImport(XCTest)
  import XCTest
#endif

#if canImport(Testing) && compiler(>=6.2)
  import Testing
#endif

/// Helper for Swift Testing attachment recording.
///
/// This helper exists because `XCTAttachment` doesn't expose its internal data - the `userInfo`
/// property is always `nil`. To create attachments for Swift Testing, we recreate the attachment
/// data from the original source values (reference/diffable) by calling `snapshotting.diffing.toData()`
/// or regenerating diff images using the internal `diff()` functions.
internal enum STAttachments {
  #if canImport(Testing) && compiler(>=6.2)
    static func record(
      _ data: Data,
      named name: String? = nil,
      fileID: StaticString,
      filePath: StaticString,
      line: UInt,
      column: UInt
    ) {
      guard Test.current != nil else { return }

      Attachment.record(
        data,
        named: name,
        sourceLocation: SourceLocation(
          fileID: fileID.description,
          filePath: filePath.description,
          line: Int(line),
          column: Int(column)
        )
      )
    }
  #else
    static func record(
      _ data: Data,
      named name: String? = nil,
      fileID: StaticString,
      filePath: StaticString,
      line: UInt,
      column: UInt
    ) {
    }
  #endif
}
