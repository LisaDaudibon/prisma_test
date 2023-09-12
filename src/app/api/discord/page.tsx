// import { getSession } from "next-auth/react";

// export default async (req:any, res:any) => {
//   const session = await getSession({ req });

//   if (!session) {
//     res.status(401).json({ error: "Unauthorized" });
//     return;
//   }

//   try {
//     const accessToken = session.token; // Get the user's access token from the session

//     // Fetch Discord guilds using the user's access token
//     const guildsResponse = await fetch("https://discord.com/api/users/@me/guilds", {
//       headers: {
//         Authorization: `Bearer ${accessToken}`,
//       },
//     });

//     if (guildsResponse.ok) {
//       const guildsData = await guildsResponse.json();
//       res.status(200).json({ guilds: guildsData });
//     } else {
//       console.error("Failed to fetch user's guilds:", guildsResponse.statusText);
//       res.status(500).json({ error: "Internal Server Error" });
//     }
//   } catch (error) {
//     console.error("Error fetching guilds:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// };