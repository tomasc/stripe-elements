const fs = require("fs")
const genericNames = require("generic-names")

const cssModulesRegex = /^((?!\.module\.).)*$/
const localIdentName = "[folder]__[name]__[local]__[hash:base64:5]"

module.exports = {
  plugins: [
    require("postcss-import"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
    require("postcss-modules")({
      generateScopedName: function(name, filename, css) {
        const generate = genericNames(localIdentName, { context: process.cwd() })
        return generate(name, filename).replace("-module", "")
      },
      globalModulePaths: [cssModulesRegex],
      getJSON: (cssFileName, json, outputFileName) => {
        if (cssModulesRegex.test(cssFileName)) return
        fs.writeFileSync(`${cssFileName}.json`, JSON.stringify(json), e =>
          e ? reject(e) : resolve(json)
        )
      }
    })
  ]
}
