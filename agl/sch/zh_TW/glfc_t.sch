/* 
================================================================================
檔案代號:glfc_t
檔案名稱:公式設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glfc_t
(
glfcent       number(5)      ,/* 企業編號 */
glfcownid       varchar2(20)      ,/* 資料所有者 */
glfcowndp       varchar2(10)      ,/* 資料所屬部門 */
glfccrtid       varchar2(20)      ,/* 資料建立者 */
glfccrtdp       varchar2(10)      ,/* 資料建立部門 */
glfccrtdt       timestamp(0)      ,/* 資料創建日 */
glfcmodid       varchar2(20)      ,/* 資料修改者 */
glfcmoddt       timestamp(0)      ,/* 最近修改日 */
glfc001       varchar2(10)      ,/* 公式編號 */
glfcseq       number(10,0)      ,/* 項次 */
glfc002       varchar2(10)      ,/* 科目參照表 */
glfc003       varchar2(24)      ,/* 起始科目 */
glfc004       varchar2(24)      ,/* 截止科目 */
glfc005       varchar2(10)      ,/* 選用核算項 */
glfc006       varchar2(10)      ,/* 起始核算項值 */
glfc007       varchar2(10)      ,/* 截止核算項值 */
glfc008       varchar2(1)      ,/* 取值方式 */
glfc009       varchar2(1)      ,/* 運算方式 */
glfc010       varchar2(500)      ,/* 額外條件 */
glfc011       varchar2(1)      ,/* 左括號 */
glfc012       varchar2(1)      ,/* 右括號 */
glfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glfc013       varchar2(1)      /* 數據來源 */
);
alter table glfc_t add constraint glfc_pk primary key (glfcent,glfc001,glfcseq) enable validate;

create unique index glfc_pk on glfc_t (glfcent,glfc001,glfcseq);

grant select on glfc_t to tiptop;
grant update on glfc_t to tiptop;
grant delete on glfc_t to tiptop;
grant insert on glfc_t to tiptop;

exit;
