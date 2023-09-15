import { GetServerSideProps, NextApiRequest, NextApiResponse } from 'next';
import { prisma } from '@/lib/prisma'
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

export default function async (req: NextApiRequest, res: NextApiResponse, ) {
  const session = getServerSession( authOptions )
  console.log("session discord", session)



  // if (req.method === 'POST') {
  //   try {
      // Assuming you have a way to identify the user, such as through a session or token
      // Replace 'userId' with the actual property you use to identify the user
      // const userId = req.user.id; // Replace with your actual way to identify the user

      // Retrieve the account associated with the user
      // const account = await prisma.account.findUnique({
      //   // where: {
      //   //   connect {
      //   //     session 
      //   //   } 
      //   // }
      // });

  //     if (account && account.access_token) {
  //       const accessToken = account.access_token;

  //       // Fetch the Discord API using the access token
  //       const response = await fetch('https://discord.com/api/users/@me/guilds', {
  //         headers: {
  //           Authorization: `Bearer ${accessToken}`,
  //         },
  //       });

  //       if (response.ok) {
  //         const guildsData = await response.json();

  //         // Process guildsData and update the database as needed
  //         // Example: Iterate through guildsData and make API calls to update the discord_guilds table
  //         for (const guild of guildsData) {
  //           await prisma.discordGuild.upsert({
  //             where: {
  //               discordGuildName: guild.name,
  //             },
  //             update: {
  //               // Update fields as needed
  //             },
  //             create: {
  //               discordGuildName: guild.name,
  //               icon: guild.icon,
  //               ownerId: guild.owner_id,
  //               approximate_number_count: guild.approximate_member_count,
  //               approximate_presence_count: guild.approximate_presence_count,
  //               description: guild.description,
  //             },
  //           });
  //         }

  //         res.status(200).json({ message: 'Discord data updated successfully' });
  //       } else {
  //         res.status(response.status).json({ message: 'Failed to fetch Discord data' });
  //       }
  //     } else {
  //       res.status(400).json({ message: 'Invalid or missing access token' });
  //     }
  //   } catch (error) {
  //     console.error(error);
  //     res.status(500).json({ message: 'Server error' });
  //   }
  // } else {
  //   res.status(405).json({ message: 'Method not allowed' });
  // }
};