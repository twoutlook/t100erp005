/* 
================================================================================
檔案代號:glfa_t
檔案名稱:報表設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glfa_t
(
glfaent       number(5)      ,/* 企業編號 */
glfa001       varchar2(10)      ,/* 報表模板編號 */
glfa002       varchar2(1)      ,/* 報表類型 */
glfa003       varchar2(1)      ,/* 排列方式 */
glfa004       varchar2(10)      ,/* 科目參照表 */
glfa005       varchar2(5)      ,/* 測試帳套 */
glfa006       number(5,0)      ,/* 測試年度 */
glfa007       number(5,0)      ,/* 測試期別 */
glfa008       varchar2(10)      ,/* 測試金額單位 */
glfa009       number(5,0)      ,/* 測試小數位數 */
glfa010       number(5,0)      ,/* 本期年度 */
glfa011       number(5,0)      ,/* 本期起始期別 */
glfa012       number(5,0)      ,/* 本期截止期別 */
glfa013       number(5,0)      ,/* 上期年度 */
glfa014       number(5,0)      ,/* 上期起始期別 */
glfa015       number(5,0)      ,/* 上期截止期別 */
glfaownid       varchar2(20)      ,/* 資料所有者 */
glfaowndp       varchar2(10)      ,/* 資料所屬部門 */
glfacrtid       varchar2(20)      ,/* 資料建立者 */
glfacrtdp       varchar2(10)      ,/* 資料建立部門 */
glfacrtdt       timestamp(0)      ,/* 資料創建日 */
glfamodid       varchar2(20)      ,/* 資料修改者 */
glfamoddt       timestamp(0)      ,/* 最近修改日 */
glfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glfa016       varchar2(1)      /* 財報類型 */
);
alter table glfa_t add constraint glfa_pk primary key (glfaent,glfa001) enable validate;

create unique index glfa_pk on glfa_t (glfaent,glfa001);

grant select on glfa_t to tiptop;
grant update on glfa_t to tiptop;
grant delete on glfa_t to tiptop;
grant insert on glfa_t to tiptop;

exit;
