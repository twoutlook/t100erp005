/* 
================================================================================
檔案代號:nmaa_t
檔案名稱:銀行帳戶主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmaa_t
(
nmaaent       number(5)      ,/* 企業編號 */
nmaaownid       varchar2(20)      ,/* 資料所有者 */
nmaaowndp       varchar2(10)      ,/* 資料所屬部門 */
nmaacrtid       varchar2(20)      ,/* 資料建立者 */
nmaacrtdt       timestamp(0)      ,/* 資料創建日 */
nmaacrtdp       varchar2(10)      ,/* 資料建立部門 */
nmaamodid       varchar2(20)      ,/* 資料修改者 */
nmaamoddt       timestamp(0)      ,/* 最近修改日 */
nmaastus       varchar2(10)      ,/* 狀態碼 */
nmaa001       varchar2(10)      ,/* 帳戶編碼 */
nmaa002       varchar2(10)      ,/* 開戶人（組織） */
nmaa003       varchar2(10)      ,/* 帳戶類型 */
nmaa004       varchar2(15)      ,/* 開戶銀行 */
nmaa005       varchar2(30)      ,/* 銀行帳號 */
nmaa006       varchar2(1)      ,/* 開通網銀否 */
nmaa007       varchar2(80)      ,/* 網銀戶名 */
nmaa008       varchar2(20)      ,/* 聯絡人識別碼 */
nmaa009       varchar2(20)      ,/* 地址識別碼 */
nmaa010       varchar2(20)      ,/* 通訊方式識別碼 */
nmaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmaa_t add constraint nmaa_pk primary key (nmaaent,nmaa001) enable validate;

create unique index nmaa_pk on nmaa_t (nmaaent,nmaa001);

grant select on nmaa_t to tiptop;
grant update on nmaa_t to tiptop;
grant delete on nmaa_t to tiptop;
grant insert on nmaa_t to tiptop;

exit;
