/* 
================================================================================
檔案代號:mmcy_t
檔案名稱:會員等級變更單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcy_t
(
mmcyent       number(5)      ,/* 企業編號 */
mmcyunit       varchar2(10)      ,/* 應用組織 */
mmcysite       varchar2(10)      ,/* 營運據點 */
mmcydocno       varchar2(20)      ,/* 單號 */
mmcy001       varchar2(30)      ,/* 會員編號 */
mmcy002       varchar2(10)      ,/* 原會員等級 */
mmcy003       varchar2(10)      ,/* 新會員等級 */
mmcy004       varchar2(10)      ,/* 會員類型 */
mmcy005       varchar2(10)      ,/* 理由碼 */
mmcy006       varchar2(30)      ,/* 升降等策略編號 */
mmcy007       varchar2(10)      ,/* 版本 */
mmcyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcy_t add constraint mmcy_pk primary key (mmcyent,mmcydocno,mmcy001) enable validate;

create unique index mmcy_pk on mmcy_t (mmcyent,mmcydocno,mmcy001);

grant select on mmcy_t to tiptop;
grant update on mmcy_t to tiptop;
grant delete on mmcy_t to tiptop;
grant insert on mmcy_t to tiptop;

exit;
