import { prisma } from '@/lib/prisma';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

export async function updateActivityData(session: any) {
  try {
    const session = await getServerSession(authOptions)
    const session_access_token = session?.user.access_token

    if (typeof session_access_token !== 'string') {
      throw new Error('Access token is not a string');
    }

    const userGlobalName:any = session?.user.global_name;
    if (!userGlobalName) {
      console.error('User global_name is null or undefined.');
      return { success: false, message: 'User global_name is null or undefined.' };
    }

    const activitiesResponse = await fetch('https://discord.com/api/users/@me/connections', {
      headers: {
        Authorization: `Bearer ${session_access_token}`,
      },
    });

    if (!activitiesResponse.ok) { 
      throw new Error('Failed to fetch Discord activity data');
    }

   const activitiesData = await activitiesResponse.json();

   await Promise.all(
    activitiesData.map(async (activity: any) => {
      const typeName:any = activity.type;

      if (!typeName) {
        console.error(`Type for activity with ID ${activity.id} is null or undefined.`);
        return;
      }

      // Find or create the corresponding Type
      const type:any = await prisma.type.upsert({
        where: { name: typeName },
        create: { name: typeName },
        update: { name: typeName },
      });

      const typename:any = await prisma.type.findUnique({
        where:
          { name: type.name }
      })

      await prisma.activity.upsert({
        where: {
          accountConnectionId: activity.id,
        },
        update: {
          friendSync: activity.friend_sync,
          showActivity: activity.show_activity,
          twoWayLink: activity.two_way_link,
          verified: activity.verified,
          updatedAt: new Date(),
        },
        create: {
          accountConnectionId: activity.id,
          activityUserName: activity.name,
          revoked: activity.revoked,
          friendSync: activity.friend_sync,
          showActivity: activity.show_activity,
          twoWayLink: activity.two_way_link,
          verified: activity.verified,
          typeName: typename,
          userGlobalName: userGlobalName,
          createdAt: new Date(),
          updatedAt: new Date(),
          type: { connect: { name: type.name } },
          user: { connect: { global_name: userGlobalName} }
        },
      });
    })
   );

  console.log('Activity data updated successfully');
    return { success: true, message: 'Discord data updated successfully' };
  } catch (error) {
    console.error('Error updating Discord activity data:', error);
    throw new Error('Error updating Discord activity data');
  }
}