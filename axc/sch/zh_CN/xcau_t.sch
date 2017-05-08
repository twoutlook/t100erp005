/* 
================================================================================
檔案代號:xcau_t
檔案名稱:成本次要素檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcau_t
(
xcauent       number(5)      ,/* 企業編號 */
xcauownid       varchar2(20)      ,/* 資料所有者 */
xcauowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaucrtid       varchar2(20)      ,/* 資料建立者 */
xcaucrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaucrtdt       timestamp(0)      ,/* 資料創建日 */
xcaumodid       varchar2(20)      ,/* 資料修改者 */
xcaumoddt       timestamp(0)      ,/* 最近修改日 */
xcaustus       varchar2(10)      ,/* 狀態碼 */
xcau001       varchar2(10)      ,/* 成本次要素編號 */
xcau002       varchar2(10)      ,/* 所屬成本次要素分類 */
xcau003       number(10)      ,/* 所屬成本主要素 */
xcauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcauud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcau_t add constraint xcau_pk primary key (xcauent,xcau001) enable validate;

create unique index xcau_pk on xcau_t (xcauent,xcau001);

grant select on xcau_t to tiptop;
grant update on xcau_t to tiptop;
grant delete on xcau_t to tiptop;
grant insert on xcau_t to tiptop;

exit;
