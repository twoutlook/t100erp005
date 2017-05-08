/* 
================================================================================
檔案代號:oofd_t
檔案名稱:預裝置註檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofd_t
(
oofdent       number(5)      ,/* 企業編號 */
oofdstus       varchar2(10)      ,/* 狀態碼 */
oofd001       varchar2(10)      ,/* 備註類型 */
oofd002       varchar2(40)      ,/* 第一key值 */
oofd003       varchar2(40)      ,/* 第二key值 */
oofd004       varchar2(40)      ,/* 第三key值 */
oofd005       varchar2(40)      ,/* 第四key值 */
oofd006       varchar2(40)      ,/* 第五key值 */
oofd007       varchar2(40)      ,/* 第六key值 */
oofd008       varchar2(40)      ,/* 第七key值 */
oofd009       varchar2(40)      ,/* 第八key值 */
oofd010       varchar2(40)      ,/* 第九key值 */
oofd011       varchar2(40)      ,/* 第十key值 */
oofd012       varchar2(4000)      ,/* 備註說明 */
oofd013       date      ,/* 失效日期 */
oofdownid       varchar2(20)      ,/* 資料所有者 */
oofdowndp       varchar2(10)      ,/* 資料所屬部門 */
oofdcrtid       varchar2(20)      ,/* 資料建立者 */
oofdcrtdp       varchar2(10)      ,/* 資料建立部門 */
oofdcrtdt       timestamp(0)      ,/* 資料創建日 */
oofdmodid       varchar2(20)      ,/* 資料修改者 */
oofdmoddt       timestamp(0)      ,/* 最近修改日 */
oofdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofd_t add constraint oofd_pk primary key (oofdent,oofd001,oofd002,oofd003,oofd004,oofd005,oofd006,oofd007,oofd008,oofd009,oofd010,oofd011) enable validate;

create unique index oofd_pk on oofd_t (oofdent,oofd001,oofd002,oofd003,oofd004,oofd005,oofd006,oofd007,oofd008,oofd009,oofd010,oofd011);

grant select on oofd_t to tiptop;
grant update on oofd_t to tiptop;
grant delete on oofd_t to tiptop;
grant insert on oofd_t to tiptop;

exit;
