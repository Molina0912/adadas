---
name: lsp-servers
description: |
  USA ESTE SKILL cuando: preguntes por servidores LSP, language servers, LSP,
  servidor de lenguaje, o necesitas configurar autocompletado para un lenguaje.
  Hace: Referencia completa de todos los servidores LSP disponibles para OpenCode
  incluyendo los built-in y los de la comunidad.
---

# LSP Servers - Referencia Completa

## Servidores LSP Built-in en OpenCode

OpenCode viene con servidores LSP integrados que se habilitan automáticamente:

| Servidor | Extensiones | Requisitos |
|----------|-------------|------------|
| astro | .astro | Autoinstalaciones para proyectos Astro |
| bash | .sh, .bash, .zsh, .ksh | Autoinstala bash language server |
| clangd | .c, .cpp, .cc, .cxx, .c++, .h, .hpp | Instalaciones automáticas C/C++ |
| csharp | .cs | .NET SDK instalado |
| clojure-lsp | .clj, .cljs, .cljc, .edn | Comando clojure-lsp disponible |
| dart | .dart | Comando dart disponible |
| deno | .ts, .tsx, .js, .jsx, .mjs | Deno disponible (detecta deno.json) |
| elixir-ls | .ex, .exs | Elixir disponible |
| eslint | .ts, .tsx, .js, .jsx, .mjs, .vue | eslint en proyecto |
| fsharp | .fs, .fsi, .fsx, .fsscript | .NET SDK |
| gleam | .gleam | Comando gleam disponible |
| gopls | .go | Go disponible |
| hls | .hs, .lhs | haskell-language-server-wrapper |
| jdtls | .java | Java SDK 21+ |
| julials | .jl | Julia + LanguageServer.jl |
| kotlin-ls | .kt, .kts | Autoinstalaciones Kotlin |
| lua-ls | .lua | Autoinstalaciones Lua |
| nixd | .nix | Comando nixd disponible |
| ocaml-lsp | .ml, .mli | Comando ocamllsp |
| oxlint | .ts, .tsx, .js, .jsx, .vue, .astro, .svelte | oxlint en proyecto |
| php-intelephense | .php | Autoinstalaciones PHP |
| prisma | .prisma | Comando prisma |
| pyright | .py, .pyi | pyright instalado |
| ruby-lsp | .rb, .rake, .gemspec, .ru | Ruby + gem |
| rust | .rs | rust-analyzer disponible |
| sourcekit-lsp | .swift, .objc, .objcpp | Swift/Xcode |
| svelte | .svelte | Autoinstalaciones Svelte |
| terraform | .tf, .tfvars | Instalaciones automáticas |
| tinymist | .typ, .typc | Instalaciones automáticas |
| typescript | .ts, .tsx, .js, .jsx, .mjs, .mts, .cts | typescript en proyecto |
| vue | .vue | Autoinstalaciones Vue |
| yaml-ls | .yaml, .yml | yaml-language-server |
| zls | .zig, .zon | Zig disponible |

## Servidores LSP de la Comunidad (Microsoft LSP Implementors)

Lista completa de todos los servidores LSP disponibles:

### A

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| 1C Enterprise | BSL Language Server | [1c-syntax/bsl-language-server](https://github.com/1c-syntax/bsl-language-server) | Java |
| ABAP | abaplint | [abaplint/abaplint](https://github.com/abaplint/abaplint) | TypeScript |
| ActionScript 2.0 | AS2 Language Support | [admvm/as2-language-support](https://github.com/admvx/as2-language-support) | TypeScript |
| Ada/SPARK | ada_language_server | [AdaCore/ada_language_server](https://github.com/AdaCore/ada_language_server) | Ada |
| Agda | agda-language-server | [agda/agda-language-server](https://github.com/agda/agda-language-server) | Haskell |
| AML | AML Language Server | [aml-org/als](https://github.com/aml-org/als) | ScalaJS |
| Ansible | Ansible Language Server | [ansible/vscode-ansible](https://github.com/ansible/vscode-ansible) | TypeScript |
| Angular | Angular Language Server | [angular/vscode-ng-language-service](https://github.com/angular/vscode-ng-language-service/tree/main/server) | TypeScript |
| Antlr | AntlrVSIX | [kaby76/AntlrVSIX](https://github.com/kaby76/AntlrVSIX) | C# |
| API Elements | vscode-apielements | [XVincentX/vscode-apielements](https://github.com/XVincentX/vscode-apielements) | TypeScript |
| APL | APL Language Server | [OptimaSystems/apl-language-server](https://github.com/OptimaSystems/apl-language-server) | APL |
| Apache Camel | Apache Camel Language Server | [camel-tooling/camel-language-server](https://github.com/camel-tooling/camel-language-server) | Java |
| Apex | VS Code Apex extension | [salesforce/salesforcedx-vscode-apex](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode-apex) | TypeScript |
| Astro | withastro/language-tools | [withastro/language-tools](https://github.com/withastro/language-tools) | TypeScript |

### B

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Bash | bash-language-server | [mads-hartmann/bash-language-server](https://github.com/mads-hartmann/bash-language-server) | TypeScript |
| Bicep | Bicep | [azure/bicep](https://github.com/azure/bicep) | C# |
| BitBake | BitBake Language Server | [yoctoproject/vscode-bitbake](https://github.com/yoctoproject/vscode-bitbake/tree/staging/server) | TypeScript |
| BrightScript/BrighterScript | brighterscript | [rokucommunity/brighterscript](https://github.com/rokucommunity/brighterscript) | TypeScript |

### C

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| C# | omnisharp-roslyn | [OmniSharp/omnisharp-roslyn](https://github.com/OmniSharp/omnisharp-roslyn) | C# |
| C# | csharp-ls | [razzmatazz/csharp-language-server](https://github.com/razzmatazz/csharp-language-server) | F# |
| C/C++ | clangd (LLVM) | [llvm/llvm-project](https://github.com/llvm/llvm-project/tree/main/clang-tools-extra/clangd) | C++ |
| C/C++/Objective-C | cquery | [jacobdufault/cquery](https://github.com/jacobdufault/cquery) | C++ |
| C/C++/Objective-C | ccls | [MaskRay/ccls](https://github.com/MaskRay/ccls) | C++ |
| Ceylon | vscode-ceylon | [jvasileff/vscode-ceylon](https://github.com/jvasileff/vscode-ceylon) | Ceylon |
| Clojure | clojure-lsp | [clojure-lsp/clojure-lsp](https://github.com/clojure-lsp/clojure-lsp) | Clojure |
| CMake | cmake-language-server | [regen100/cmake-language-server](https://github.com/regen100/cmake-language-server) | Python |
| CMake | neocmakelsp | [Decodetalkers/neocmakelsp](https://github.com/Decodetalkers/neocmakelsp) | Rust |
| COBOL | rech-editor-cobol | [RechInformatica/rech-editor-cobol](https://github.com/RechInformatica/rech-editor-cobol) | TypeScript |
| CoffeeScript | CoffeeSense | [phil294/coffeesense](https://github.com/phil294/coffeesense/) | TypeScript |
| Crystal | Crystalline | [elbywan/crystalline](https://github.com/elbywan/crystalline) | Crystal |
| Cucumber/Gherkin | Cucumber Language Server | [cucumber/language-server](https://github.com/cucumber/language-server) | TypeScript |

### D

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| D | serve-d | [Pure-D/serve-d](https://github.com/Pure-D/serve-d) | D |
| D | D Language Server | [d-language-server/dls](https://github.com/d-language-server/dls) | D |
| Dart | Dart SDK | [dart-lang/sdk](https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md) | Dart |
| Dockerfile | docker-language-server | [docker/docker-language-server](https://github.com/docker/docker-language-server) | Go |
| Dockerfile | dockerfile-language-server | [rcjsuen/dockerfile-language-server-nodejs](https://github.com/rcjsuen/dockerfile-language-server-nodejs) | TypeScript |

### E

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Elixir | elixir-ls | [elixir-lsp/elixir-ls](https://github.com/elixir-lsp/elixir-ls) | Elixir |
| Elm | elmLS | [elm-tooling/elm-language-server](https://github.com/elm-tooling/elm-language-server) | TypeScript |
| Ember | Ember Language Server | [lifeart/ember-language-server](https://github.com/lifeart/ember-language-server) | TypeScript |
| Erlang | erlang_ls | [erlang-ls/erlang_ls](https://github.com/erlang-ls/erlang_ls) | Erlang |
| Erlang | ELP | [whatsapp/erlang-language-platform](https://github.com/whatsapp/erlang-language-platform) | Rust/Erlang |

### F

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| F# | F# Language Server | [georgewfraser/fsharp-language-server](https://github.com/georgewfraser/fsharp-language-server) | F# |
| F# | FsAutoComplete | [fsharp/FsAutoComplete](https://github.com/fsharp/FsAutoComplete) | F# |
| Fortran | fortran-language-server | [hansec/fortran-language-server](https://github.com/hansec/fortran-language-server) | Python |
| Fortran | fortls | [gnikit/fortls](https://github.com/gnikit/fortls) | Python |

### G

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| GDScript | Godot | [godotengine/godot](https://github.com/godotengine/godot) | C++ |
| Gleam | gleam | [gleam-lang/gleam](https://github.com/gleam-lang/gleam) | Rust |
| Go | gopls | [golang/tools](https://github.com/golang/tools/tree/master/gopls) | Go |
| Go | sourcegraph-go | [sourcegraph/go-langserver](https://github.com/sourcegraph/go-langserver) | Go |
| GraphQL | Official GraphQL Language Server | [graphql/graphiql](https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-server) | TypeScript |
| Groovy | groovy-language-server | [palantir/groovy-language-server](https://github.com/palantir/groovy-language-server/) | Java |

### H

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Haskell | Haskell Language Server (HLS) | [haskell/haskell-language-server](https://github.com/haskell/haskell-language-server) | Haskell |
| Haxe | Haxe Language Server | [vshaxe/haxe-language-server](https://github.com/vshaxe/haxe-language-server) | Haxe |
| Helm | helm-ls | [mrjosh/helm-ls](https://github.com/mrjosh/helm-ls) | Go |
| HTML | vscode-html-languageserver | [Microsoft/vscode](https://github.com/Microsoft/vscode/tree/master/extensions/html-language-features/server) | TypeScript |

### J

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Java | Eclipse JDT LS | [eclipse/eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls/) | Java |
| JavaScript | quick-lint-js | [quick-lint/quick-lint-js](https://github.com/quick-lint/quick-lint-js) | C++ |
| JavaScript Flow | flow-language-server | [flowtype/flow-language-server](https://github.com/flowtype/flow-language-server) | JavaScript |
| JavaScript/TypeScript | javascript-typescript | [sourcegraph/javascript-typescript-langserver](https://github.com/sourcegraph/javascript-typescript-langserver) | TypeScript |
| JavaScript/TypeScript | biome_lsp | [biomejs/biome](https://github.com/biomejs/biome/tree/main/crates/biome_lsp) | Rust |
| JSON | vscode-json-languageserver | [vscode-json-languageserver](https://www.npmjs.com/package/vscode-json-languageserver) | TypeScript |
| Julia | Julia language server | [JuliaEditorSupport/LanguageServer.jl](https://github.com/JuliaEditorSupport/LanguageServer.jl) | Julia |

### K

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Kotlin | kotlin-language-server | [fwcd/kotlin-language-server](https://github.com/fwcd/kotlin-language-server) | Kotlin |
| Kotlin | kotlin-lsp | [Kotlin/kotlin-lsp](https://github.com/Kotlin/kotlin-lsp) | Kotlin |

### L

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| LaTeX | texlab | [efoerster/texlab](https://github.com/efoerster/texlab) | Rust |
| Lua | lua-lsp | [Alloyed/lua-lsp](https://github.com/Alloyed/lua-lsp) | Lua |
| Lua | lua-language-server | [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server) | Lua |

### M

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Markdown | Marksman | [artempyanykh/marksman](https://github.com/artempyanykh/marksman) | F# |
| Markdown | vscode-markdown-languageserver | [microsoft/vscode-markdown-languageserver](https://github.com/microsoft/vscode-markdown-languageserver) | TypeScript |
| MATLAB | MATLAB-language-server | [mathworks/MATLAB-language-server](https://github.com/mathworks/MATLAB-language-server) | TypeScript |

### N

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Nim | nimlsp | [PMunch/nimlsp](https://github.com/PMunch/nimlsp) | Nim |

### O

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| OCaml/Reason | ocamllsp | [ocaml/ocaml-lsp](https://github.com/ocaml/ocaml-lsp) | OCaml |
| Odin | ols | [DanielGavin/ols](https://github.com/DanielGavin/ols) | Odin |

### P

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| PHP | intelephense | [bmewburn/intelephense](https://github.com/bmewburn/intelephense) | TypeScript |
| PHP | php-language-server | [felixfbecker/php-language-server](https://github.com/felixfbecker/php-language-server) | PHP |
| Python | pyright | [microsoft/pyright](https://github.com/microsoft/pyright) | TypeScript |
| Python | basedpyright | [detachHead/basedpyright](https://github.com/detachHead/basedpyright) | TypeScript |
| Python | python-lsp-server | [python-lsp/python-lsp-server](https://github.com/python-lsp/python-lsp-server) | Python |
| Python | jedi-language-server | [samroeca/jedi-language-server](https://github.com/samroeca/jedi-language-server) | Python |
| Python | pylyzer | [erg-lang/pylyzer](https://github.com/erg-lang/pylyzer) | Rust |
| Python | ty | [astral-sh/ty](https://github.com/astral-sh/ty) | Rust |

### R

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| R | R language server | [REditorSupport/r-languageserver](https://github.com/REditorSupport/r-languageserver) | R |
| Ruby | ruby-lsp | [Shopify/ruby-lsp](https://github.com/Shopify/ruby-lsp) | Ruby |
| Ruby | solargraph | [castwide/solargraph](https://github.com/castwide/solargraph) | Ruby |
| Ruby | sorbet | [Shopify/sorbet](https://github.com/Shopify/sorbet) | C++ |
| Rust | rust-analyzer | [rust-lang/rust-analyzer](https://github.com/rust-lang/rust-analyzer) | Rust |

### S

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Scala | Metals | [scalameta/metals](https://github.com/scalameta/metals) | Scala |
| Svelte | svelte-language-server | [sveltejs/language-server](https://github.com/sveltejs/language-server) | TypeScript |
| Swift | SourceKit-LSP | [apple/sourcekit-lsp](https://github.com/apple/sourcekit-lsp) | Swift |
| SystemVerilog | svls | [dalance/svls](https://github.com/dalance/svls) | Rust |
| SystemVerilog | Verible | [chipsalliance/verible](https://github.com/chipsalliance/verible) | C++ |

### T

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Terraform | terraform-ls | [hashicorp/terraform-ls](https://github.com/hashicorp/terraform-ls) | Go |
| TOML | Taplo | [tamasfe/taplo](https://github.com/tamasfe/taplo) | Rust |
| TypeScript | typescript-language-server | [theia-ide/typescript-language-server](https://github.com/theia-ide/typescript-language-server) | TypeScript |
| Typst | tinymist | [Myriad-Dreamin/tinymist](https://github.com/Myriad-Dreamin/tinymist) | Rust |
| Typst | typst-lsp | [nvarner/typst-lsp](https://github.com/nvarner/typst-lsp) | Rust |

### V

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| V | v-analyzer | [v-analyzer/v-analyzer](https://github.com/v-analyzer/v-analyzer) | V |
| VHDL | vhdl_ls | [vhdl-ls/rust_hdl](https://github.com/vhdl-ls/rust_hdl) | Rust |
| Viml | vim-language-server | [iamcco/vim-language-server](https://github.com/iamcco/vim-language-server) | TypeScript |
| Vue | vuejs/language-tools | [vuejs/language-tools](https://github.com/vuejs/language-tools) | TypeScript |

### W

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| WebAssembly | wasm-language-tools | [g-plane/wasm-language-tools](https://github.com/g-plane/wasm-language-tools) | Rust |
| Wolfram Language | lsp-wl | [kenkangxgwe/lsp-wl](https://github.com/kenkangxgwe/lsp-wl) | Wolfram |

### Y

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| YANG | yang-lsp | [RedHat-SE/yang-lsp](https://github.com/RedHat-SE/yang-lsp) | XTend |
| YARA | YARA Language Server | [avast/yara-ida](https://github.com/avast/yara-ida) | Python |
| YAML | yaml-language-server | [redhat-developer/yaml-language-server](https://github.com/redhat-developer/yaml-language-server) | TypeScript |

### Z

| Lenguaje | Servidor | Repo | Lenguaje Impl. |
|----------|----------|------|----------------|
| Zig | zls | [zigtools/zls](https://github.com/zigtools/zls) | Zig |
| Nix | nil | [oxalica/nil](https://github.com/nix-community/nil) | Rust |
| Nix | nixd | [nix-community/nixd](https://github.com/nix-community/nixd) | C++ |

### Genéricos/Multi

| Servidor | Repo | Lenguaje Impl. |
|----------|------|----------------|
| efm-langserver | [mattn/efm-langserver](https://github.com/mattn/efm-langserver) | Go |
| diagnostic-languageserver | [iamcco/diagnostic-languageserver](https://github.com/iamcco/diagnostic-languageserver) | TypeScript |
| SonarLint Language Server | [SonarSource/sonarlint-core](https://github.com/SonarSource/sonarlint-core) | Java |
| @github/copilot-language-server | [github/copilot-language-server](https://github.com/github/copilot-language-server) | JavaScript |

## Cómo Configurar LSP Personalizados

```json
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": {
    "custom-lsp": {
      "command": ["custom-lsp-server", "--stdio"],
      "extensions": [".custom"],
      "env": {
        "RUST_LOG": "debug"
      },
      "initialization": {
        "preferences": {}
      }
    }
  }
}
```

## Deshabilitar Servidores

```json
{
  "lsp": false
}
```

```json
{
  "lsp": {
    "typescript": {
      "disabled": true
    }
  }
}
```

## Variables de Entorno

```json
{
  "lsp": {
    "rust": {
      "env": {
        "RUST_LOG": "debug"
      }
    }
  }
}
```

## Fuente

[Microsoft LSP Implementors - Language Servers](https://microsoft.github.io/language-server-protocol/implementors/servers/)

[OpenCode LSP Documentation](https://opencode.ai/docs/)