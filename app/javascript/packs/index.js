import "../components"

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../components", true, /\.coffee$/)

application.load(definitionsFromContext(context))
