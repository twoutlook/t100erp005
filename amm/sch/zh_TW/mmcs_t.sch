/* 
================================================================================
檔案代號:mmcs_t
檔案名稱:會員等級升降策略申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcs_t
(
mmcsent       number(5)      ,/* 企業編號 */
mmcsunit       varchar2(10)      ,/* 應用組織 */
mmcssite       varchar2(10)      ,/* 營運據點 */
mmcsdocno       varchar2(20)      ,/* 單號 */
mmcs001       varchar2(30)      ,/* 升降等策略編號 */
mmcs002       varchar2(10)      ,/* 會員等級編號 */
mmcs003       number(10,0)      ,/* 組別 */
mmcs004       number(10,0)      ,/* 序號 */
mmcs005       varchar2(10)      ,/* 會員升等條件 */
mmcs006       number(5,0)      ,/* 統計區間（月） */
mmcs007       number(20,6)      ,/* 下限 */
mmcs008       number(20,6)      ,/* 上限 */
mmcsacti       varchar2(1)      ,/* 資料有效碼 */
mmcsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcs_t add constraint mmcs_pk primary key (mmcsent,mmcsdocno,mmcs002,mmcs003,mmcs004) enable validate;

create unique index mmcs_pk on mmcs_t (mmcsent,mmcsdocno,mmcs002,mmcs003,mmcs004);

grant select on mmcs_t to tiptop;
grant update on mmcs_t to tiptop;
grant delete on mmcs_t to tiptop;
grant insert on mmcs_t to tiptop;

exit;
