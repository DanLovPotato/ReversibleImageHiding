# Reversible Image Transition Based on an Iteration Method

This project involves performing reversible image transformations to embed a secret image into a target image.

Traditional image encryption methods typically involve transforming an image into complete noise, rendering the image visually incomprehensible. While this approach effectively conceals the original content, it has a significant drawback: the presence of noise makes it immediately apparent to attackers that the image contains secret information. This visibility can attract unwanted attention and increase the likelihood of decryption attempts.

To address this issue, this method takes a different approach by encrypting the image into another visually meaningful image. By transforming the secret image into an innocuous-looking target image, this technique minimizes the chances of drawing attention to the encrypted content. The resulting image appears normal and unremarkable, making it less likely to be suspected of containing hidden information. 



## Project Structure

```txt
project_directory/
├── code/          # Directory containing the main script and all relevant functions
│   ├── main.m     # Main script to run the entire pipeline
│   ├── matfiles/  # Stores all intermediate .mat files generated during the image processing steps.
│   ├── RDH/       # Contains functions related to reversible data hiding, such as embedding.m, LSB.m, Sachnev.m, etc.
│   └── utilities/ # Contains general utility functions like appraise.m, K_means.m, and huffman.m
├── data/          # Input data
├── results/       # Output results
└── README.md      # Project doc
```



## Outputs

The outputs of the process include:

- `final.png`: The final stego image with the secret image embedded.
- `transfer1.png`: The image after the first round of transformation.
- `transfer2.png`: The image after the second round of transformation.