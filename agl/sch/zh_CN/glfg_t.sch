/* 
================================================================================
檔案代號:glfg_t
檔案名稱:非T100公司科目餘額暫存資料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glfg_t
(
glfgent       number(5)      ,/* 企業代碼 */
glfgownid       varchar2(20)      ,/* 資料所有者 */
glfgowndp       varchar2(10)      ,/* 資料所屬部門 */
glfgcrtid       varchar2(20)      ,/* 資料建立者 */
glfgcrtdp       varchar2(10)      ,/* 資料建立部門 */
glfgcrtdt       timestamp(0)      ,/* 資料創建日 */
glfgmodid       varchar2(20)      ,/* 資料修改者 */
glfgmoddt       timestamp(0)      ,/* 最近修改日 */
glfgcnfid       varchar2(20)      ,/* 資料確認者 */
glfgcnfdt       timestamp(0)      ,/* 資料確認日 */
glfgstus       varchar2(10)      ,/* 狀態碼 */
glfg001       varchar2(10)      ,/* 公司編號 */
glfg002       varchar2(5)      ,/* 帳別 */
glfg005       number(5,0)      ,/* 年度 */
glfg006       number(5,0)      ,/* 期別 */
glfg007       varchar2(10)      ,/* 幣別(記帳幣) */
glfg008       varchar2(10)      ,/* 幣別(功能幣) */
glfg009       varchar2(10)      ,/* 幣別(報告幣) */
glfgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glfg_t add constraint glfg_pk primary key (glfgent,glfg001,glfg002,glfg005,glfg006) enable validate;

create unique index glfg_pk on glfg_t (glfgent,glfg001,glfg002,glfg005,glfg006);

grant select on glfg_t to tiptop;
grant update on glfg_t to tiptop;
grant delete on glfg_t to tiptop;
grant insert on glfg_t to tiptop;

exit;
