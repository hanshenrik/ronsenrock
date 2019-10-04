# Hjemmeside for [RønsenRock](https://rønsenrock.no)

## Running
```
$ yarn dev
```
## Issues
Using `elm-style-animation` as a dependency causes a weird dev server error with both Parcel and Webpack.
```
/src/Main.elm: Compilation failed
Success! Compiled 1 module.                                          
elm: Map.!: given key is not an element in the map
CallStack (from HasCallStack):
  error, called at libraries/containers/Data/Map/Internal.hs:603:17 in containers-0.5.10.2:Data.Map.Internal
```

Fixed by keeping the library as a local module ¯\\\_(ツ)\_/¯.
