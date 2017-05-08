/* 
================================================================================
檔案代號:glbg_t
檔案名稱:揭露事項說明檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glbg_t
(
glbgent       number(5)      ,/* 企業編號 */
glbgownid       varchar2(20)      ,/* 資料所有者 */
glbgowndp       varchar2(10)      ,/* 資料所屬部門 */
glbgcrtid       varchar2(20)      ,/* 資料建立者 */
glbgcrtdp       varchar2(10)      ,/* 資料建立部門 */
glbgcrtdt       timestamp(0)      ,/* 資料創建日 */
glbgmodid       varchar2(20)      ,/* 資料修改者 */
glbgmoddt       timestamp(0)      ,/* 最近修改日 */
glbgstus       varchar2(10)      ,/* 狀態碼 */
glbgld       varchar2(5)      ,/* 帳別編號 */
glbg001       varchar2(10)      ,/* 報表類型 */
glbg002       number(5,0)      ,/* 年度 */
glbg003       number(5,0)      ,/* 期別 */
glbg004       number(10,0)      ,/* 行序 */
glbg005       varchar2(80)      ,/* 說明 */
glbg006       number(20,6)      ,/* 金額 */
glbg007       varchar2(1)      ,/* 使用分類 */
glbg008       number(20,10)      ,/* 匯率(本位幣二) */
glbg009       number(20,6)      ,/* 金額(本位幣二) */
glbg010       number(20,10)      ,/* 匯率(本位幣三) */
glbg011       number(20,6)      ,/* 金額(本位幣三) */
glbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glbg_t add constraint glbg_pk primary key (glbgent,glbgld,glbg001,glbg002,glbg003,glbg004) enable validate;

create unique index glbg_pk on glbg_t (glbgent,glbgld,glbg001,glbg002,glbg003,glbg004);

grant select on glbg_t to tiptop;
grant update on glbg_t to tiptop;
grant delete on glbg_t to tiptop;
grant insert on glbg_t to tiptop;

exit;
