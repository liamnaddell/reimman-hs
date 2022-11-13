module Main where

f (x,y) = x*exp(-1*x*y)

d :: Integer -> Double
d a = fromIntegral a

-- change indices to be integers
type  Cij = (Double -> Double -> Integer -> Integer -> Integer -> (Double, Double))

bottom_left :: Cij
bottom_left a b n i j = (dx*(d i - 1.0),dy*(d j-1.0))
    where dx = (b-a)/(d n)
          dy = (b-a)/(d n)

top_right :: Cij
top_right a b n i j = (dx*(d i),dy*(d j))
    where dx = (b-a)/(d n)
          dy = (b-a)/(d n)

center :: Cij
center a b n i j = (((fst bl)+(fst tr))/2, ((snd bl)+(snd tr))/2)
    where bl = bottom_left a b n i j
          tr = top_right a b n i j

reimman :: ((Double,Double) -> Double) -> Cij -> Integer -> Double -> Double -> Double
reimman f cij n a b = sum single_sum
    where indices = [(x,y) | x <- [1..n], y <- [1..n]]
          cijf = cij a b n
          dx = (b-a)/(d n)
          single_sum = map (\((i,j)) -> (f $ cijf i j)*dx) indices



main :: IO ()
main = do
   let bl = reimman f bottom_left 3 0 3
   putStrLn $ "Bottom Left sum: " ++ (show bl)

   let cr = reimman f center 3 0 3
   putStrLn $ "Center sum: " ++ (show cr)

   let tr = reimman f top_right 3 0 3
   putStrLn $ "Top Right sum: " ++ (show tr)
