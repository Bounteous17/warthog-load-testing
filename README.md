# Warthog

:warning: This project is still under development :warning:

<a href="https://github.com/onebeyond/warthog-load-testing">**_Warthog_**</a> is a powerful tool to launch your <a href="https://en.wikipedia.org/wiki/Load_testing#Software_load_testing">**load tests**</a> without any kind of limitation when it comes to choosing the level of load or the types of resources you want to test.

Key features:

-   **Friendly**: It is developed to provide the greatest possible simplicity to developers.
-   **Familiar**: The tests needs to be created by using <a href="https://developer.mozilla.org/en-US/docs/Learn/JavaScript/First_steps/What_is_JavaScript">JavaScript</a>, which is a versatile and widely-used programming language.
-   **Simplicity**: The tests are executed under the <a href="https://nodejs.org">Node.js</a> runtime, which offers a robust ecosystem, efficient performance, and extensive libraries, simplifying the development process.
-   **Performance**: Optimized to reduce latencies when calculating the test suite scores.
-   **Limitless**: It supports **any protocol** that the <a href="https://nodejs.org/api/all.html">runtime allows</a>, you don't need to extend anything.

## Usage

Normal use mode:
```bash
pnpm start
```

Or use it on debug mode for a verbose output:
```
DEBUG="warthog:*" pnpm start
```

## Configuration

Create an `.env` file with your custom values:

```bash
# Amount of CPU threads executing the test scripts.
SCRIPT_PARALLELISM=2
# The path in which to find the scripts to be executed
WARTHOG_TESTS_PATH=./tests
```

## Examples

There is an already developed <a href="https://github.com/onebeyond/warthog-load-testing">**_Warthog_**</a> project full of load test scripts already developed. That one can be found under the <a href="https://github.com/onebeyond/warthog-load-testing/tree/main/example">example</a> folder of this repository.

The tool is ready for being integrated with a continuous integration pipeline, enabling quality assurance processes and effortless execution of scripts for automated testing.

## Principles

- **Measure performance** between **future versions** of this framework to observe that **performance does not worsen**. The new features cannot decrease the total number of iterations that could be executed before. This could lead to misunderstandings since it could lead to the conclusion that the system that the end user is testing has worsened its performance. When it really is not like that, what has happened is that its iterations take longer to execute due to a worsening in the framework runtime during the same tasks during each execution.

- The [non blocking](https://nodejs.org/en/docs/guides/blocking-vs-non-blocking) pattern has been kept in mind before starting to develop this software. This is the perfect example to once again remember that new behaviors in the code that go against this principle will not be accepted. In order to follow this principle from the beginning [node workers](https://nodejs.org/api/worker_threads.html) has been used on there that allow to stay aligned with the non blocking pattern.

- We assume that the contributors of this tool are not responsible for the damage that some users may cause to external systems that are not authorized to be tested by them.

## Considerations

- Since Jest v29 does [not support ECMAScript modules natively](https://jestjs.io/docs/ecmascript-modules) yet and for avoiding to use of external compilers for module-type transformations like [Babel](https://babeljs.io/) the application code must remain using CommonJS modules.

## Contribute

If you want to contribute or help with the development of Warthog, start by reading `CONTRIBUTING.md`.

## The insides

<img src="docs/diagrams/how_it_works_internals.svg" />