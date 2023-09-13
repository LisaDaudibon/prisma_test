"use client";

import { signIn } from "next-auth/react";
import { useSearchParams } from "next/navigation";


export const LoginForm = () => {

  const searchParams = useSearchParams();
  const callbackUrl = searchParams.get("callbackUrl") || "/profile";

  return (
      <a
        className="px-7 py-2 text-white font-medium text-sm leading-snug uppercase rounded shadow-md hover:shadow-lg focus:shadow-lg focus:outline-none focus:ring-0 active:shadow-lg transition duration-150 ease-in-out w-full flex justify-center items-center mb-3"
        style={{ backgroundColor: "#3b5998" }}
        onClick={() => signIn("discord", { callbackUrl })}
        // onClick={() => signIn("discord", { callbackUrl }, {prompt: "none" })}
        role="button"
      >
        {/* <img
          className="pr-2"
          src="/images/google.svg"
          alt=""
          style={{ height: "2rem" }}
        /> */}
        Continue with Discord
      </a>
  );
};
