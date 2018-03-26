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
    let args = ProcessInfo.processInfo.arguments
    let env = ProcessInfo.processInfo.environment
    let yamlPath = helper.getYamlPath(args: args, env: env)
    try helper.run(arguments: args,
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

