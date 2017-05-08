/* 
================================================================================
檔案代號:bgci_t
檔案名稱:模擬期別分配設置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgci_t
(
bgcient       number(5)      ,/* 企業編號 */
bgci001       varchar2(10)      ,/* 預算編號 */
bgci002       varchar2(10)      ,/* 預算版本 */
bgci003       varchar2(10)      ,/* 預算組織 */
bgci004       number(5,0)      ,/* 期別 */
bgci005       number(20,6)      ,/* 權數 */
bgci006       varchar2(10)      ,/* 時間跨度 */
bgciownid       varchar2(20)      ,/* 資料所有者 */
bgciowndp       varchar2(10)      ,/* 資料所屬部門 */
bgcicrtid       varchar2(20)      ,/* 資料建立者 */
bgcicrtdp       varchar2(10)      ,/* 資料建立部門 */
bgcicrtdt       timestamp(0)      ,/* 資料創建日 */
bgcimodid       varchar2(20)      ,/* 資料修改者 */
bgcimoddt       timestamp(0)      ,/* 最近修改日 */
bgcistus       varchar2(10)      ,/* 狀態碼 */
bgciud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgciud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgciud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgciud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgciud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgciud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgciud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgciud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgciud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgciud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgciud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgciud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgciud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgciud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgciud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgciud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgciud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgciud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgciud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgciud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgciud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgciud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgciud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgciud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgciud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgciud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgciud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgciud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgciud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgciud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgci_t add constraint bgci_pk primary key (bgcient,bgci001,bgci002,bgci003,bgci004) enable validate;

create unique index bgci_pk on bgci_t (bgcient,bgci001,bgci002,bgci003,bgci004);

grant select on bgci_t to tiptop;
grant update on bgci_t to tiptop;
grant delete on bgci_t to tiptop;
grant insert on bgci_t to tiptop;

exit;
