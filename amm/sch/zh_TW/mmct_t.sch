/* 
================================================================================
檔案代號:mmct_t
檔案名稱:會員等級升降策略卡種範圍設定申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmct_t
(
mmctent       number(5)      ,/* 企業編號 */
mmctunit       varchar2(10)      ,/* 應用組織 */
mmctsite       varchar2(10)      ,/* 營運據點 */
mmctdocno       varchar2(20)      ,/* 單號 */
mmct001       varchar2(30)      ,/* 升降等策略編號 */
mmct002       varchar2(10)      ,/* 卡種編號 */
mmctacti       varchar2(1)      ,/* 資料有效碼 */
mmctud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmctud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmctud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmctud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmctud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmctud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmctud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmctud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmctud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmctud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmctud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmctud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmctud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmctud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmctud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmctud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmctud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmctud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmctud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmctud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmctud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmctud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmctud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmctud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmctud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmctud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmctud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmctud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmctud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmctud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmct_t add constraint mmct_pk primary key (mmctent,mmctdocno,mmct002) enable validate;

create unique index mmct_pk on mmct_t (mmctent,mmctdocno,mmct002);

grant select on mmct_t to tiptop;
grant update on mmct_t to tiptop;
grant delete on mmct_t to tiptop;
grant insert on mmct_t to tiptop;

exit;
