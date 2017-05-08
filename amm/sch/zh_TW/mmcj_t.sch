/* 
================================================================================
檔案代號:mmcj_t
檔案名稱:換贈贈品資訊申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcj_t
(
mmcjent       number(5)      ,/* 企業編號 */
mmcjsite       varchar2(10)      ,/* 營運據點 */
mmcjunit       varchar2(10)      ,/* 應用組織 */
mmcjdocno       varchar2(20)      ,/* 單據編號 */
mmcj001       varchar2(30)      ,/* 活動規則編號 */
mmcj002       varchar2(10)      ,/* 卡種編號 */
mmcj003       number(10,0)      ,/* 換贈組別 */
mmcj004       varchar2(10)      ,/* 換贈資料類型 */
mmcj005       varchar2(40)      ,/* 資料編號 */
mmcj006       varchar2(10)      ,/* 單位 */
mmcj007       number(20,6)      ,/* 贈送數量 */
mmcj008       varchar2(10)      ,/* 附屬條件 */
mmcj009       number(20,6)      ,/* 換贈加價/加積點 */
mmcj010       number(20,6)      ,/* 換贈會員加價/加積點 */
mmcj011       number(10,0)      ,/* 上限名額 */
mmcj012       varchar2(10)      ,/* 上限統計時間範圍 */
mmcjacti       varchar2(1)      ,/* 有效 */
mmcjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcj_t add constraint mmcj_pk primary key (mmcjent,mmcjdocno,mmcj003,mmcj004,mmcj005) enable validate;

create unique index mmcj_pk on mmcj_t (mmcjent,mmcjdocno,mmcj003,mmcj004,mmcj005);

grant select on mmcj_t to tiptop;
grant update on mmcj_t to tiptop;
grant delete on mmcj_t to tiptop;
grant insert on mmcj_t to tiptop;

exit;
