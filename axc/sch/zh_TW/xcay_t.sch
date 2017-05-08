/* 
================================================================================
檔案代號:xcay_t
檔案名稱:科目與成本次要素對應主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcay_t
(
xcayent       number(5)      ,/* 企業編號 */
xcayownid       varchar2(20)      ,/* 資料所有者 */
xcayowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaycrtid       varchar2(20)      ,/* 資料建立者 */
xcaycrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaycrtdt       timestamp(0)      ,/* 資料創建日 */
xcaymodid       varchar2(20)      ,/* 資料修改者 */
xcaymoddt       timestamp(0)      ,/* 最近修改日 */
xcaystus       varchar2(10)      ,/* 狀態碼 */
xcayld       varchar2(5)      ,/* 帳別 */
xcay001       varchar2(24)      ,/* 科目 */
xcay002       varchar2(10)      ,/* 成本次要素 */
xcayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcay_t add constraint xcay_pk primary key (xcayent,xcayld,xcay001) enable validate;

create unique index xcay_pk on xcay_t (xcayent,xcayld,xcay001);

grant select on xcay_t to tiptop;
grant update on xcay_t to tiptop;
grant delete on xcay_t to tiptop;
grant insert on xcay_t to tiptop;

exit;
