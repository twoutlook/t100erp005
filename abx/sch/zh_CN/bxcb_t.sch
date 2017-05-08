/* 
================================================================================
檔案代號:bxcb_t
檔案名稱:保稅產品結構取替代檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxcb_t
(
bxcbent       number(5)      ,/* 企業編號 */
bxcbsite       varchar2(10)      ,/* 營運據點 */
bxcb001       number(5,0)      ,/* 流用代號 */
bxcb002       varchar2(40)      ,/* 料件編號 */
bxcb003       date      ,/* 生效日期 */
bxcb004       date      ,/* 失效日期 */
bxcb005       varchar2(40)      ,/* 核准文號 */
bxcb006       date      ,/* 核准日期 */
bxcbownid       varchar2(20)      ,/* 資料所有者 */
bxcbowndp       varchar2(10)      ,/* 資料所屬部門 */
bxcbcrtid       varchar2(20)      ,/* 資料建立者 */
bxcbcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxcbcrtdt       timestamp(0)      ,/* 資料創建日 */
bxcbmodid       varchar2(20)      ,/* 資料修改者 */
bxcbmoddt       timestamp(0)      ,/* 最近修改日 */
bxcbcnfid       varchar2(20)      ,/* 資料確認者 */
bxcbcnfdt       timestamp(0)      ,/* 資料確認日 */
bxcbstus       varchar2(10)      ,/* 狀態碼 */
bxcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxcb_t add constraint bxcb_pk primary key (bxcbent,bxcbsite,bxcb001,bxcb002) enable validate;

create unique index bxcb_pk on bxcb_t (bxcbent,bxcbsite,bxcb001,bxcb002);

grant select on bxcb_t to tiptop;
grant update on bxcb_t to tiptop;
grant delete on bxcb_t to tiptop;
grant insert on bxcb_t to tiptop;

exit;
