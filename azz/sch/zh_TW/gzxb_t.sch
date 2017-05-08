/* 
================================================================================
檔案代號:gzxb_t
檔案名稱:使用者對角色或作業配置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxb_t
(
gzxbstus       varchar2(10)      ,/* 狀態碼 */
gzxbent       number(5)      ,/* 企業編號 */
gzxb001       varchar2(20)      ,/* 員工編號 */
gzxb002       varchar2(1)      ,/* 類別 */
gzxb003       varchar2(20)      ,/* 角色或作業編號 */
gzxb004       date      ,/* 生效日期 */
gzxb005       date      ,/* 失效日期 */
gzxbownid       varchar2(20)      ,/* 資料所有者 */
gzxbowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxbcrtid       varchar2(20)      ,/* 資料建立者 */
gzxbcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxbcrtdt       timestamp(0)      ,/* 資料創建日 */
gzxbmodid       varchar2(20)      ,/* 資料修改者 */
gzxbmoddt       timestamp(0)      ,/* 最近修改日 */
gzxb006       varchar2(1)      ,/* 部門資料授權 */
gzxb007       varchar2(1)      ,/* 個人資料授權 */
gzxb008       varchar2(1)      ,/* 單身處理方式 */
gzxbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxb_t add constraint gzxb_pk primary key (gzxbent,gzxb001,gzxb002,gzxb003) enable validate;

create unique index gzxb_pk on gzxb_t (gzxbent,gzxb001,gzxb002,gzxb003);

grant select on gzxb_t to tiptop;
grant update on gzxb_t to tiptop;
grant delete on gzxb_t to tiptop;
grant insert on gzxb_t to tiptop;

exit;
