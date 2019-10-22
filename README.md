<p align="center">
    <img src="https://github.com/no-stack-dub-sack/ApexDox-sample-app/raw/master/doc-assets/ApexDox.png"
         alt="ApexDox Logo" style="max-width:100%;">
</p>

# ApexDox-Sample-App
This project **is not** an actual, working, Apex project! This is a mock codebase, intended only to demonstrate the [ApexDox VSCode](https://github.com/no-stack-dub-sack/apexdox-vs-code) project. Throughout its .cls files, you will find "doc block" comments (see [example](https://github.com/no-stack-dub-sack/ApexDox-sample-app/blob/f60333708d8ce45eea5f65b7d3aec4920abd4576/force-app/main/default/classes/BotController.cls#L1)), which self-document each file. When the ApexDox VSCode extension is run on this project, these comments will be parsed and converted into static documentation. **The generated documentation can be viewed [here](https://apexdox-sample-docs.surge.sh)**.

To test this out, clone this repository and open it in VSCode. Then install the ApexDox VSCode extension and use its built-in commands.

You can launch the following commands via the command pallette (<kbd>Ctrl/Cmd</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>):
- **ApexDox: Run**: Run ApexDox. Many aspects of how this command behaves can be configured using the settings below.
- **ApexDox: Open Docs**: Launch a server on localhost and open the generated documentation.
- **ApexDox: Stub Comment Block**: On the line above a method, class/interface, property, or enum, invoke this command to stub an ApexDox comment based on the current context. This command can also be invoked by completion item: type `/**` and press <kbd>Tab</kbd> when prompted. The appearance / style of comment stubs can be configured using the settings below.

The output documentation can be configured using the settings in `.vscode/settings.json`, or, if enabled, the settings in `.apexdoxrc` or `apexdox.yml` (both of which will take precedence over `settings.json`, if present). See the ApexDox VS Code extension's [README](https://github.com/no-stack-dub-sack/apexdox-vs-code/blob/feat/search/README.md) for more information.

## Credits
The majority of the code in this sample app is taken from Salesforce's Dreamhouse app. To see or install the actual Dreamhouse application, visit: https://github.com/dreamhouseapp/dreamhouse-sfdx.