# Unpoly for Seaside
[Unpoly](https://unpoly.com/) is an unobtrusive Javascript framework for applications that render on the server. It allows your views to do things that are not normally possible in HTML.

**Unpoly for Seaside** is an add-on library for [Seaside](https://github.com/SeasideSt/Seaside) which provides easy access to Unpoly's core features using familiar Smalltalk and Seaside code patterns.

## Getting Started
* Install [Pharo](https://pharo.org/) (currently tested with Pharo 13)

## Installation
* Evaluate:
```smalltalk
Metacello new
    repository: 'github://rko281/Unpoly-Pharo:main';
    baseline: 'Unpoly';
    load: 'default'
```
* All required packages and prerequisites (including [Seaside](https://github.com/seasidest/seaside) and [Seaside-Bootstrap5](https://github.com/astares/Seaside-Bootstrap5)) will be downloaded and installed.

## Run
 - Ensure the Seaside web server is running
 - Open your browser on [http://localhost:8080/unpoly/introduction](http://localhost:8080/unpoly/introduction) to try the examples

## Examples
The examples browser demonstrates most of the wrapped behavior. Browse `UpExamplesBrowser` for further information.
