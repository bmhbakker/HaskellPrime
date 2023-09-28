-- Voor elke functie is er een Start en End toegevoegd om duidelijk te maken wat bij elkaar hoort.
-- De code kan aangeroepen worden in een termianl door ghci sieve.hs aan te roepen. Ook kan de code worden gecompileerd naar een .exe bestand. Deze kan
-- vervolgens ook worden uitgevoerd.



import Data.Time.Clock.POSIX ( getPOSIXTime )
{-==================== START ISNOTDIVISIBLE ====================-}
-- We definiëren een "isNotDivisible" functie die twee variabelen krijgt en een true of false terug geeft
isNotDivisible :: Int -> Int -> Bool
isNotDivisible prime numberToCheck = 
    -- Hier wordt geken wat de uitkomst is van numberToCheck mod prime. 'mod' in Haskell is het bekende Modulus (of %).
    -- modulus geeft de rest waarde bij een deling (9 : 5 = 1 rest 4) Als de waarde nul is dan kan numberToCheck gedeeld worden door prime. 
    -- De functie zal dan false returnen (dit wordt gecheckt door /= 0 dit is te vergelijken maar niet exact hetzelfde als != 0 in bijvoorbeeld Java). Als 
    -- NumberToCheck niet te delen is door prime (en dus een restwaarde geeft) dan zal dit true returnen en betekenen dat het getal mogelijk een priemgetal is.
    numberToCheck `mod` prime /= 0
{-==================== END ISNOTDIVISIBLE ====================-}



{-==================== START SIEVE ====================-}
-- Hier definiëren we de functie "sieve" die de waarde n aanneemt en een lijst van integers teruggeeft als resultaat
sieve :: Int -> [Int]

-- De regels hieronder kunnen worden gezien als een if statement. Als n kleiner is dan 2 wordt er een lege lijst gereturned. Als dit echter niet het geval
-- is dan gaan we verder naar de seiveMethod.
sieve n
    | n < 2     = []
    | otherwise = sieveMethod [2..n] []
{-==================== END SIEVE ====================-}



{-==================== START SIEVE METHOD====================-}
-- Hier wordt de functie "sieveMethod" gedefinieerd. De eerste variabele is de lijst van 2 tot en met n waar n > 2. De tweede lijst is eerst leeg maar wordt
-- later gevuld met de priemgetallen. In dit voorbeeld wordt de sieve van Erastothenes gebruikt om priemgetallen uit te rekenen. De bekendste en snelste
-- manier om deze uit te rekenen. Het haalt alle getallen die niet priem kunnen zijn uit de lijst (als 2 priem is dan zijn 2, 4, 6 etc dat niet.)
sieveMethod :: [Int] -> [Int] -> [Int]

-- Omdat de priemgetallen achterstevoren in de lijst worden geplaatst moeten we deze nog omdraaien. In plaats van 997, 991 ... 3, 2 krijgen we dus 2, 3 ...
sieveMethod [] primes = reverse primes

-- Deze regel is waar alles in principe gebeurt. Deze regel zorgt voor onze priemgetallen.
-- currentPrime:listOfNumbers is een soort van iterator. currentPrime is elke keer het eerste getal in de lijst en listOfNumbers is de rest van de getallen 
-- die nog niet gefilterd zijn. primes is hier de lijst die uiteindelijk alle priemgetallen bevat. sieveMethod kan zichzelf weer aanroepen met nieuwe waarde's 
-- om de rest van de getallen te filteren. het filteren gebeurd door alle waarde's (die in de lijst staan) te delen door currentPrime. Dit gebeurd in de 
-- isNotDivisible functie. Als er geen nummers meer zijn om te checken zal alles afronden, primes uiteindelijk alle getallen bevatten en in de goeie volgorde 
-- de lijst returnen 
sieveMethod (currentPrime:listOfNumbers) primes = sieveMethod (filter (isNotDivisible currentPrime) listOfNumbers) (currentPrime:primes)
{-==================== END SIEVE METHOD ====================-}



{-==================== START MAIN/PROGRAM ====================-}
main :: IO ()
main = do
    -- Dit is waar de code wordt gestart en het resultaat wordt getoond. Als eerst wordt er gevraagd om een limiet in te stellen. 
    -- Het limit wordt gebruikt om alle priem getallen van 2 tot en met limiet te tonen. het ophalen van de ingevoerde waarde is input <- getLine
    -- Hierna maken pakken we de tijd "getPOSIXTime". Dit kan later worden gebruikt om te kijken hoe lang de code er over deed.
    putStrLn "Enter an upper limit for prime generation:"
    input <- getLine
    startTimeFunction <- getPOSIXTime
    
    -- Limit is hier de ingevoerde waarde door de gebruiker. Primes is in principe alleen de function call met het limiet, al wordt deze nog niet uitgevoerd
    -- door Lazy Evalueation.
    let limit = read input :: Int
    let primes = sieve limit

    -- Het printen wat hier staat is pas wanneer de code prime gaat berekenen. "primes" is hier de function call met het limiet en word hier dus uitgevoerd.
    -- Hierna wordt de eindtijd opgeslagen en wordt uiteindelijk getoond hoelang het heeft geduurd om de code te runnen.
    putStrLn $ "Primes up to " ++ show limit ++ ": " ++ show primes
    endTimeFunction <- getPOSIXTime
    let functionDuration = endTimeFunction - startTimeFunction

    putStrLn $ "\nThe full function took " ++ show functionDuration ++ " seconds to run"
    {-==================== END MAIN/PROGRAM ====================-}