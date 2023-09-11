import { getServerSession } from "next-auth";
import Header from "@/components/header.components";
import { authOptions } from "@/lib/auth";

export default async function Profile() {
  const session = await getServerSession(authOptions);
  const user = session?.user;
  // console.log(session?.user)

  return (
    <>
      <Header />
      <section className="bg-ct-blue-600  min-h-screen pt-20">
        <div className="max-w-4xl mx-auto bg-ct-dark-100 rounded-md h-[20rem] flex justify-center items-center">
          <div>
            <p className="mb-3 text-5xl text-center font-semibold">
              Profile Page New
            </p>
            {!user ? (
              <p>Loading...</p>
            ) : (
              <div className="flex items-center gap-8">
                <div>
                  <img
                    src={user.image ? user.image : "/images/default.png"}
                    className="max-h-36"
                    alt={`profile photo of ${user.name}`}
                  />
                </div>
                <div className="mt-8">
                  <p className="mb-3">Name: {user.name}</p>
                  <p className="mb-3">Name: {user.name}</p>
                  <p className="mb-3">Global Name: {user.global_username}</p>
                  <p className="mb-3">Email: {user.email}</p>
                  <p className="mb-3">Discriminator: {user.discriminator}</p>
                  <p className="mb-3">
                    Utilisateur vérifié: {user.verified ? 'True' : 'False'}
                  </p>
                  <p className="mb-3">
                    Double authentification activée: {user.mfa_enabled ? 'True' : 'False'}
                  </p>
                  <img
                    src={user.banner ? user.banner : "/images/default.png"}
                    className="max-h-36"
                    alt={`profile photo of ${user.name}`}
                  />
                </div>
              </div>
            )}
          </div>
        </div>
      </section>
    </>
  );
}
