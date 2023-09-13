// import type { NextApiRequest, NextApiResponse } from "next"
// import NextAuth from "next-auth"

// export default async function auth(req: NextApiRequest, res: NextApiResponse) {



//   // Get a custom cookie value from the request

//   return await NextAuth(req, res, {
//     ...,

//     callbacks: {
//       session({ session, token }) {
//         // Return a cookie value as part of the session
//         // This is read when `req.query.nextauth.includes("session") && req.method === "GET"`
        
//         return session
//       }
//     }
//   })
// }