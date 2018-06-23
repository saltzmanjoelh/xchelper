//
//  XcodeHelperCli.swift
//  XcodeHelper
//
//  Created by Joel Saltzman on 8/28/16.
//
//

import Foundation
import XcodeHelperKit
import CliRunnable
import XcodeHelperCliKit

// !!!: static build like this - `swift build -Xswiftc -static-stdlib`

/*
 - Run Script Phase -
 xchelper docker-build
 xchelper create-archive "$TARGET_BUILD_DIR/$PRODUCT_NAME" "$TARGET_BUILD_DIR/$PRODUCT_NAME.tar"
 xchelper upload-archive "$TARGET_BUILD_DIR/$PRODUCT_NAME.tar" -c "$SOURCE_ROOT/credentials"
 */

let helper = XCHelper(xcodeHelpable:XcodeHelper())
do {
    let args = ProcessInfo.processInfo.arguments
    let env = ProcessInfo.processInfo.environment
    let configPathKeys = [XCHelper.changeDirectoryOption.short.rawValue, XCHelper.changeDirectoryOption.long.rawValue]
    let yamlPath = helper.getYamlPath(possibleKeys: configPathKeys, args: args, env: env).appending(".xcodehelper")
    _ = try helper.run(arguments: args,
                   environment: env,
                   yamlConfigurationPath: yamlPath)
} catch let e as XcodeHelperError {
    print(e.description)
    if case XcodeHelperError.dockerBuild(let buildError) = e {
        exit(buildError.exitCode)
    }

} catch let e as CliRunnableError {
    print(e.description)

} catch let e {
    print(e)
}

