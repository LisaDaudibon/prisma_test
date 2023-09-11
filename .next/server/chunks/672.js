"use strict";
exports.id = 672;
exports.ids = [672];
exports.modules = {

/***/ 8672:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {


// EXPORTS
__webpack_require__.d(__webpack_exports__, {
  L: () => (/* binding */ authOptions)
});

// EXTERNAL MODULE: external "@prisma/client"
var client_ = __webpack_require__(3524);
;// CONCATENATED MODULE: ./src/lib/prisma.ts

const globalForPrisma = global;
const prisma = globalForPrisma.prisma || new client_.PrismaClient({
    log: [
        "query"
    ]
});
if (false) {}

// EXTERNAL MODULE: ./node_modules/@next-auth/prisma-adapter/dist/index.js
var dist = __webpack_require__(966);
// EXTERNAL MODULE: ./node_modules/next-auth/providers/discord.js
var discord = __webpack_require__(8384);
;// CONCATENATED MODULE: ./src/lib/auth.ts



const authOptions = {
    // This is a temporary fix for prisma client.
    // @see https://github.com/prisma/prisma/issues/16117
    adapter: (0,dist/* PrismaAdapter */.N)(prisma),
    pages: {
        signIn: "/login"
    },
    session: {
        strategy: "jwt"
    },
    providers: [
        (0,discord/* default */.Z)({
            clientId: process.env.DISCORD_CLIENT_ID,
            clientSecret: process.env.DISCORD_CLIENT_SECRET,
            authorization: {
                params: {
                    scope: "identify email guilds guilds.members.read connections"
                }
            },
            // connection: "https://discord.com/api/users/@me/connections",
            profile (profile) {
                console.log("Received Profile:", profile);
                if (profile.avatar === null) {
                    const defaultAvatarNumber = parseInt(profile.discriminator) % 5;
                    profile.image_url = `https://cdn.discordapp.com/embed/avatars/${defaultAvatarNumber}.png`;
                } else {
                    const format = profile.avatar.startsWith("a_") ? "gif" : "png";
                    profile.image_url = `https://cdn.discordapp.com/avatars/${profile.id}/${profile.avatar}.${format}`;
                }
                return {
                    id: profile.id,
                    name: profile.username,
                    discriminator: profile.discriminator,
                    global_username: profile.global_username,
                    verified: profile.verified,
                    mfa_enabled: profile.mfa_enabled,
                    banner: profile.banner,
                    email: profile.email,
                    image: profile.image_url,
                    playerName: profile.playerName
                };
            }
        })
    ],
    callbacks: {
        async redirect ({ baseUrl }) {
            return `${baseUrl}/openloot`;
        },
        session: ({ session, token })=>{
            return {
                ...session,
                user: {
                    ...session.user,
                    id: token.id,
                    discriminator: token.discriminator,
                    global_username: token.global_username,
                    verified: token.verified,
                    mfa_enabled: token.mfa_enabled,
                    banner: token.banner,
                    playerName: token.playerName
                }
            };
        },
        jwt: ({ token, user })=>{
            if (user) {
                const u = user;
                return {
                    ...token,
                    id: u.id,
                    discriminator: u.discriminator,
                    global_username: u.global_username,
                    verified: u.verified,
                    mfa_enabled: u.mfa_enabled,
                    banner: u.banner,
                    playerName: u.playerName
                };
            }
            return token;
        }
    }
};


/***/ })

};
;