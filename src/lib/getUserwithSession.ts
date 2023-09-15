import { getServerSession } from 'next-auth';
import {prisma} from './prisma';
import { authOptions } from './auth';

export async function getUserWithSesssion ( session:any) {
  session = await getServerSession(authOptions)
  console.log("Hello session", session.user)

  return prisma.user.findUnique({
    where: {
      email: session.user.email
    },
    include: {
      accounts: {
        select: {
          access_token: true,
        }
      }
    }
  })
}