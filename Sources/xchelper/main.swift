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

let helper = XCHelper(xcodeHelpable:XcodeHelper())
do {
    try helper.run(arguments:ProcessInfo.processInfo.arguments,
                   environment:ProcessInfo.processInfo.environment,
                   yamlConfigurationPath: ProcessInfo.processInfo.environment["PWD"]?.appending("/.xcodehelper"))
} catch let e as XcodeHelperError {
    print(e.description)
    if case XcodeHelperError.dockerBuild(let buildError) = e {
        exit(buildError.exitCode)
    }

} catch let e as CliRunnableError {
    print(e.description)
}

