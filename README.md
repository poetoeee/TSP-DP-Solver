<h2 align="center">Traveling Salesperson Problem (TSP) Solver</h2>
<p align="center"><em>PR IF2211 Strategi Algoritma 2025</em></p>


This project is an implementation of a solver for the Traveling Salesperson Problem (TSP) using a dynamic programming approach. The program is written in **Ruby**.

## Project Structure

The repository is organized as follows:
<pre>
.
├── src/
│   └── tsp_dp.rb              # Main application source code
├── test/
│   ├── input/
│   │   └── sample_1.txt       # Example input file
│   └── output/
│   └── Screenshoot/
└── README.md   
  
</pre>


## How to Run the Program

### Prerequisites

* **Ruby** must be installed on your system.

### Installation
<ol>
  <li><strong>Clone the Repository:</strong>
    <pre><code class="lang-bash">git clone https://github.com/poetoeee/TSP-DP-SOLVER
cd TSP-DP-SOLVER</code></pre>
  </li>
  <li><strong>Run the Application:</strong>
    <pre><code class="lang-bash">ruby src/tsp_dp.rb</code></pre>
  </li>
</ol>

## File Formats

### Input File

The program accepts manual input or input files from the `test/input/` directory.

* Each line represents a row in the cost matrix.
* Values in a row are separated by commas.
* The matrix must be square (number of rows equals number of columns).

**Example: `sample_1.txt`**
```
0,10,15,20
5,0,9,10
6,13,0,12
8,8,9,0
```
Example: result_sample_1.txt

```
Tanggal: 2025-05-26 22:37:11

Matriks Biaya yang Digunakan:
[0, 10, 15, 20]
[5, 0, 9, 10]
[6, 13, 0, 12]
[8, 8, 9, 0]

HASIL PERHITUNGAN:
Bobot tur terpendek: 35
Jalur tur optimal: 1 -> 2 -> 4 -> 3 -> 1
```
