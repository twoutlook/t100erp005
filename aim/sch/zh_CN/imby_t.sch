/* 
================================================================================
檔案代號:imby_t
檔案名稱:商品准入單流通多條碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imby_t
(
imbyent       number(5)      ,/* 企業編號 */
imbydocno       varchar2(20)      ,/* 申請單號 */
imby001       varchar2(40)      ,/* 商品編號 */
imby002       varchar2(10)      ,/* 條碼類型 */
imby003       varchar2(40)      ,/* 條碼 */
imby004       varchar2(10)      ,/* 包裝單位 */
imby005       number(20,6)      ,/* 件裝數 */
imby006       varchar2(1)      ,/* 主條碼否 */
imby007       number(20,6)      ,/* 陳列規格(深) */
imby008       number(20,6)      ,/* 陳列規格(寬) */
imby009       number(20,6)      ,/* 陳列規格(高) */
imby010       number(20,6)      ,/* 體積 */
imby011       number(20,6)      ,/* 重量 */
imby012       varchar2(10)      ,/* 計價單位 */
imby013       number(20,6)      ,/* 計價單位換算率 */
imby014       varchar2(10)      ,/* 庫存單位 */
imby015       varchar2(10)      ,/* 長度單位 */
imby016       varchar2(10)      ,/* 體積單位 */
imby017       varchar2(10)      ,/* 重量單位 */
imbystus       varchar2(10)      ,/* 資料有效碼 */
imbyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbyud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imby018       varchar2(10)      /* 傳秤因子 */
);
alter table imby_t add constraint imby_pk primary key (imbyent,imbydocno,imby003) enable validate;

create unique index imby_pk on imby_t (imbyent,imbydocno,imby003);

grant select on imby_t to tiptop;
grant update on imby_t to tiptop;
grant delete on imby_t to tiptop;
grant insert on imby_t to tiptop;

exit;
