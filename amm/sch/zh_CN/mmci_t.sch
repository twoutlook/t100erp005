/* 
================================================================================
檔案代號:mmci_t
檔案名稱:換贈規則申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmci_t
(
mmcient       number(5)      ,/* 企業編號 */
mmcisite       varchar2(10)      ,/* 營運據點 */
mmciunit       varchar2(10)      ,/* 應用組織 */
mmcidocno       varchar2(20)      ,/* 單據編號 */
mmci001       varchar2(30)      ,/* 活動規則編號 */
mmci002       varchar2(10)      ,/* 卡種編號 */
mmci003       number(10,0)      ,/* 換贈組別 */
mmci004       number(20,6)      ,/* 換贈積點/累計消費額 */
mmci005       number(5,0)      ,/* 兌換品種數 */
mmciacti       varchar2(1)      ,/* 有效 */
mmciud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmciud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmciud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmciud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmciud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmciud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmciud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmciud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmciud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmciud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmciud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmciud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmciud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmciud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmciud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmciud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmciud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmciud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmciud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmciud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmciud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmciud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmciud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmciud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmciud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmciud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmciud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmciud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmciud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmciud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmci_t add constraint mmci_pk primary key (mmcient,mmcidocno,mmci003) enable validate;

create unique index mmci_pk on mmci_t (mmcient,mmcidocno,mmci003);

grant select on mmci_t to tiptop;
grant update on mmci_t to tiptop;
grant delete on mmci_t to tiptop;
grant insert on mmci_t to tiptop;

exit;
