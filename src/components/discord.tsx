"use client"
import { useEffect } from "react";

export default function Discord () {
  useEffect(() => {
    // Function to update Discord data
    const updateDiscordData = async () => {
      try {
        const response = await fetch('/api/discord', {
          method: 'POST',
        });

        if (response.ok) {
          console.log('Discord data updated successfully');
        } else {
          console.error('Failed to update Discord data');
        }
      } catch (error) {
        console.error('Error updating Discord data:', error);
      }
    };

    // Call the function to update Discord data on component mount
    updateDiscordData();
  }, []); // The empty dependency array ensures this effect runs only on mount

  return (
    <>
      <p>Hello world ! </p>
    </>
  )
}