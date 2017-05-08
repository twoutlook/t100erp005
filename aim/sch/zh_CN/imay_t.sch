/* 
================================================================================
檔案代號:imay_t
檔案名稱:商品條碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imay_t
(
imayent       number(5)      ,/* 企業編號 */
imay001       varchar2(40)      ,/* 商品編號 */
imay002       varchar2(10)      ,/* 條碼類型 */
imay003       varchar2(40)      ,/* 條碼 */
imay004       varchar2(10)      ,/* 包裝單位 */
imay005       number(20,6)      ,/* 件裝數 */
imay006       varchar2(1)      ,/* 主條碼否 */
imay007       number(20,6)      ,/* 陳列規格(深) */
imay008       number(20,6)      ,/* 陳列規格(寬) */
imay009       number(20,6)      ,/* 陳列規格(高) */
imay010       number(20,6)      ,/* 體積 */
imay011       number(20,6)      ,/* 重量 */
imay012       varchar2(10)      ,/* 計價單位 */
imay013       number(20,6)      ,/* 計價單位換算率 */
imay014       varchar2(10)      ,/* 庫存單位 */
imay015       varchar2(10)      ,/* 長度單位 */
imay016       varchar2(10)      ,/* 體積單位 */
imay017       varchar2(10)      ,/* 重量單位 */
imayownid       varchar2(20)      ,/* 資料所有者 */
imayowndp       varchar2(10)      ,/* 資料所屬部門 */
imaycrtid       varchar2(20)      ,/* 資料建立者 */
imaycrtdp       varchar2(10)      ,/* 資料建立部門 */
imaycrtdt       timestamp(0)      ,/* 資料創建日 */
imaymodid       varchar2(20)      ,/* 資料修改者 */
imaymoddt       timestamp(0)      ,/* 最近修改日 */
imaystus       varchar2(10)      ,/* 狀態碼 */
imayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imayud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imay018       varchar2(10)      /* 傳秤因子 */
);
alter table imay_t add constraint imay_pk primary key (imayent,imay003) enable validate;

create unique index imay_pk on imay_t (imayent,imay003);

grant select on imay_t to tiptop;
grant update on imay_t to tiptop;
grant delete on imay_t to tiptop;
grant insert on imay_t to tiptop;

exit;
