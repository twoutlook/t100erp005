/* 
================================================================================
檔案代號:mmcp_t
檔案名稱:卡折扣進階規則申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcp_t
(
mmcpent       number(5)      ,/* 企業編號 */
mmcpsite       varchar2(10)      ,/* 營運據點 */
mmcpunit       varchar2(10)      ,/* 應用組織 */
mmcpdocno       varchar2(20)      ,/* 單據編號 */
mmcp001       varchar2(20)      ,/* 活動規則編號 */
mmcp002       varchar2(10)      ,/* 卡種編號 */
mmcp003       varchar2(10)      ,/* 進階規則類型 */
mmcp004       varchar2(10)      ,/* 進階規則編碼 */
mmcp005       varchar2(1)      ,/* 互斥 */
mmcp006       number(10,0)      ,/* 優先序 */
mmcp007       varchar2(10)      ,/* 紀念日回饋條件 */
mmcp008       number(5,0)      ,/* 紀念日前(日) */
mmcp009       number(5,0)      ,/* 紀念日後(日) */
mmcp010       number(20,6)      ,/* 折扣率 */
mmcp011       date      ,/* 開始日期 */
mmcp012       date      ,/* 結束日期 */
mmcp013       varchar2(8)      ,/* 每日開始時間 */
mmcp014       varchar2(8)      ,/* 每日結束時間 */
mmcp015       varchar2(10)      ,/* 固定日期 */
mmcp016       varchar2(10)      ,/* 固定星期 */
mmcpacti       varchar2(1)      ,/* 資料有效 */
mmcpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcp_t add constraint mmcp_pk primary key (mmcpent,mmcpdocno,mmcp003,mmcp004) enable validate;

create unique index mmcp_pk on mmcp_t (mmcpent,mmcpdocno,mmcp003,mmcp004);

grant select on mmcp_t to tiptop;
grant update on mmcp_t to tiptop;
grant delete on mmcp_t to tiptop;
grant insert on mmcp_t to tiptop;

exit;
