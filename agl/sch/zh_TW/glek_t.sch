/* 
================================================================================
檔案代號:glek_t
檔案名稱:合併現金流量表間接法人工輸入金額設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glek_t
(
glekent       number(5)      ,/* 企業編號 */
glekld       varchar2(5)      ,/* 合併帳別 */
glek001       varchar2(10)      ,/* 上層公司 */
glek002       number(5,0)      ,/* 年度 */
glek003       number(5,0)      ,/* 期別 */
glek004       varchar2(10)      ,/* 群組代碼 */
glek005       varchar2(24)      ,/* 科目編號 */
glek006       number(10,0)      ,/* 項次 */
glek007       varchar2(10)      ,/* 幣別(記帳幣) */
glek008       number(20,6)      ,/* 人工輸入借方金額(記帳幣) */
glek009       number(20,6)      ,/* 人工輸入貸方金額(記帳幣) */
glek010       varchar2(10)      ,/* 幣別(功能幣) */
glek011       number(20,6)      ,/* 人工輸入借方金額(功能幣) */
glek012       number(20,6)      ,/* 人工輸入貸方金額(功能幣) */
glek013       varchar2(10)      ,/* 幣別(報告幣) */
glek014       number(20,6)      ,/* 人工輸入借方金額(報告幣) */
glek015       number(20,6)      ,/* 人工輸入貸方金額(報告幣) */
glekownid       varchar2(20)      ,/* 資料所有者 */
glekowndp       varchar2(10)      ,/* 資料所屬部門 */
glekcrtid       varchar2(20)      ,/* 資料建立者 */
glekcrtdp       varchar2(10)      ,/* 資料建立部門 */
glekcrtdt       timestamp(0)      ,/* 資料創建日 */
glekmodid       varchar2(20)      ,/* 資料修改者 */
glekmoddt       timestamp(0)      ,/* 最近修改日 */
glekstus       varchar2(10)      ,/* 狀態碼 */
glekud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glekud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glekud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glekud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glekud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glekud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glekud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glekud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glekud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glekud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glekud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glekud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glekud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glekud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glekud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glekud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glekud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glekud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glekud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glekud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glekud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glekud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glekud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glekud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glekud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glekud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glekud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glekud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glekud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glekud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glek_t add constraint glek_pk primary key (glekent,glekld,glek001,glek002,glek003,glek004,glek005,glek006) enable validate;

create unique index glek_pk on glek_t (glekent,glekld,glek001,glek002,glek003,glek004,glek005,glek006);

grant select on glek_t to tiptop;
grant update on glek_t to tiptop;
grant delete on glek_t to tiptop;
grant insert on glek_t to tiptop;

exit;
