/* 
================================================================================
檔案代號:glfi_t
檔案名稱:合併報表長期投資成本法轉權益法維護單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glfi_t
(
glfient       number(5)      ,/* 企業編號 */
glfild       varchar2(5)      ,/* 合併帳套 */
glfi001       varchar2(10)      ,/* 投資公司 */
glfi002       number(5,0)      ,/* 年度 */
glfi003       number(5,0)      ,/* 期別 */
glfi004       varchar2(20)      ,/* 傳票單號 */
glfistus       varchar2(10)      ,/* 狀態碼 */
glfiownid       varchar2(20)      ,/* 資料所有者 */
glfiowndp       varchar2(10)      ,/* 資料所屬部門 */
glficrtid       varchar2(20)      ,/* 資料建立者 */
glficrtdp       varchar2(10)      ,/* 資料建立部門 */
glficrtdt       timestamp(0)      ,/* 資料創建日 */
glfimodid       varchar2(20)      ,/* 資料修改者 */
glfimoddt       timestamp(0)      ,/* 最近修改日 */
glficnfid       varchar2(20)      ,/* 資料確認者 */
glficnfdt       timestamp(0)      ,/* 資料確認日 */
glfipstid       varchar2(20)      ,/* 資料過帳者 */
glfipstdt       timestamp(0)      ,/* 資料過帳日 */
glfiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glfi_t add constraint glfi_pk primary key (glfient,glfild,glfi001,glfi002,glfi003) enable validate;

create unique index glfi_pk on glfi_t (glfient,glfild,glfi001,glfi002,glfi003);

grant select on glfi_t to tiptop;
grant update on glfi_t to tiptop;
grant delete on glfi_t to tiptop;
grant insert on glfi_t to tiptop;

exit;
