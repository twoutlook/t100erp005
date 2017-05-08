/* 
================================================================================
檔案代號:sfod_t
檔案名稱:工單製程變更check in/out項目資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfod_t
(
sfodent       number(5)      ,/* 企業代碼 */
sfodsite       varchar2(10)      ,/* 營運據點 */
sfoddocno       varchar2(20)      ,/* 工單單號 */
sfod001       varchar2(10)      ,/* RUN CARD */
sfod002       number(10,0)      ,/* 項次 */
sfod003       varchar2(10)      ,/* 項目 */
sfod004       varchar2(1)      ,/* 型態 */
sfod005       number(15,3)      ,/* 下限 */
sfod006       number(15,3)      ,/* 上限 */
sfod007       varchar2(80)      ,/* 預設值 */
sfod008       varchar2(1)      ,/* 必要 */
sfod900       number(10,0)      ,/* 變更序 */
sfod901       varchar2(1)      ,/* 變更類型 */
sfod902       date      ,/* 變更時間 */
sfod905       varchar2(10)      ,/* 變更理由 */
sfod906       varchar2(255)      ,/* 變更備註 */
sfod009       varchar2(1)      ,/* Check in/out */
sfodseq       number(10,0)      ,/* 項序 */
sfodud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfodud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfodud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfodud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfodud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfodud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfodud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfodud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfodud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfodud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfodud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfodud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfodud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfodud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfodud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfodud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfodud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfodud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfodud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfodud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfodud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfodud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfodud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfodud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfodud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfodud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfodud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfodud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfodud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfodud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfod_t add constraint sfod_pk primary key (sfodent,sfoddocno,sfod001,sfod002,sfod003,sfod004,sfod900,sfod009,sfodseq) enable validate;

create unique index sfod_pk on sfod_t (sfodent,sfoddocno,sfod001,sfod002,sfod003,sfod004,sfod900,sfod009,sfodseq);

grant select on sfod_t to tiptop;
grant update on sfod_t to tiptop;
grant delete on sfod_t to tiptop;
grant insert on sfod_t to tiptop;

exit;
