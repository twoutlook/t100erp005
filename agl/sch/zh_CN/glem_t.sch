/* 
================================================================================
檔案代號:glem_t
檔案名稱:合併現金流量表間接法期初開帳金額設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glem_t
(
glement       number(5)      ,/* 企業編號 */
glemld       varchar2(5)      ,/* 合併帳別 */
glem001       varchar2(10)      ,/* 上層公司 */
glem002       number(5,0)      ,/* 年度 */
glem003       number(5,0)      ,/* 期別 */
glem004       varchar2(10)      ,/* 群組代碼 */
glem005       varchar2(24)      ,/* 科目編號 */
glem006       varchar2(10)      ,/* 幣別(記帳幣) */
glem007       number(20,6)      ,/* 期初借方金額(記帳幣) */
glem008       number(20,6)      ,/* 期初貸方金額(記帳幣) */
glem009       varchar2(10)      ,/* 幣別(功能幣) */
glem010       number(20,6)      ,/* 期初借方金額(功能幣) */
glem011       number(20,6)      ,/* 期初貸方金額(功能幣) */
glem012       varchar2(10)      ,/* 幣別(報告幣) */
glem013       number(20,6)      ,/* 期初借方金額(報告幣) */
glem014       number(20,6)      ,/* 期初貸方金額(報告幣) */
glemownid       varchar2(20)      ,/* 資料所有者 */
glemowndp       varchar2(10)      ,/* 資料所屬部門 */
glemcrtid       varchar2(20)      ,/* 資料建立者 */
glemcrtdp       varchar2(10)      ,/* 資料建立部門 */
glemcrtdt       timestamp(0)      ,/* 資料創建日 */
glemmodid       varchar2(20)      ,/* 資料修改者 */
glemmoddt       timestamp(0)      ,/* 最近修改日 */
glemstus       varchar2(10)      ,/* 狀態碼 */
glemud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glemud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glemud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glemud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glemud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glemud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glemud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glemud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glemud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glemud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glemud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glemud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glemud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glemud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glemud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glemud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glemud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glemud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glemud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glemud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glemud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glemud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glemud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glemud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glemud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glemud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glemud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glemud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glemud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glemud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glem_t add constraint glem_pk primary key (glement,glemld,glem001,glem002,glem003,glem004,glem005) enable validate;

create unique index glem_pk on glem_t (glement,glemld,glem001,glem002,glem003,glem004,glem005);

grant select on glem_t to tiptop;
grant update on glem_t to tiptop;
grant delete on glem_t to tiptop;
grant insert on glem_t to tiptop;

exit;
