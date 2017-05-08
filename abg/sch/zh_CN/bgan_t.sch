/* 
================================================================================
檔案代號:bgan_t
檔案名稱:預算現金碼對應檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgan_t
(
bganent       number(5)      ,/* 企業編號 */
bgan001       varchar2(5)      ,/* 預算現金異動碼表編碼 */
bgan002       varchar2(5)      ,/* 對應現金變動碼表編號 */
bgan003       varchar2(10)      ,/* 預算現金變動碼 */
bgan004       varchar2(10)      ,/* 對應組織現金變動碼 */
bganownid       varchar2(20)      ,/* 資料所有者 */
bganowndp       varchar2(10)      ,/* 資料所屬部門 */
bgancrtid       varchar2(20)      ,/* 資料建立者 */
bgancrtdp       varchar2(10)      ,/* 資料建立部門 */
bgancrtdt       timestamp(0)      ,/* 資料創建日 */
bganmodid       varchar2(20)      ,/* 資料修改者 */
bganmoddt       timestamp(0)      ,/* 最近修改日 */
bganstus       varchar2(10)      ,/* 有效碼 */
bganud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bganud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bganud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bganud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bganud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bganud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bganud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bganud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bganud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bganud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bganud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bganud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bganud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bganud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bganud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bganud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bganud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bganud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bganud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bganud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bganud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bganud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bganud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bganud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bganud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bganud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bganud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bganud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bganud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bganud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgan_t add constraint bgan_pk primary key (bganent,bgan001,bgan002,bgan004) enable validate;

create unique index bgan_pk on bgan_t (bganent,bgan001,bgan002,bgan004);

grant select on bgan_t to tiptop;
grant update on bgan_t to tiptop;
grant delete on bgan_t to tiptop;
grant insert on bgan_t to tiptop;

exit;
