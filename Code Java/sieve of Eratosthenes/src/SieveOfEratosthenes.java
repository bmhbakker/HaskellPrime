import java.util.*;

public class SieveOfEratosthenes {
    public static List<Integer> sieveOfEratosthenes(int n) {
        boolean[] isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;

        for (int p = 2; p * p <= n; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= n; i += p) {
                    isPrime[i] = false;
                }
            }
        }

        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= n; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }

        return primes;
    }

    public static void main(String[] args) {
        int n = 1000000000; // Change this to the desired range
        int beginTime = (int) System.currentTimeMillis();

        List<Integer> primes = sieveOfEratosthenes(n);
        System.out.println("Prime numbers up to " + n + ":");
        for (int prime : primes) {
            System.out.print(prime + " ");
        }

        int endTime = (int) System.currentTimeMillis();
        System.out.println("\n Time taken: " + (endTime - beginTime) + "ms");
    }
}
