/* 
================================================================================
檔案代號:mmbr_t
檔案名稱:卡積點進階規則申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbr_t
(
mmbrent       number(5)      ,/* 企業編號 */
mmbrunit       varchar2(10)      ,/* 應用組織 */
mmbrsite       varchar2(10)      ,/* 營運據點 */
mmbrdocno       varchar2(20)      ,/* 單據編號 */
mmbr001       varchar2(20)      ,/* 活動規則編號 */
mmbr002       varchar2(10)      ,/* 卡種編號 */
mmbr003       varchar2(10)      ,/* 進階規則類型 */
mmbr004       varchar2(10)      ,/* 進階規則編碼 */
mmbr005       varchar2(1)      ,/* 互斥 */
mmbr006       number(10,0)      ,/* 優先序 */
mmbr007       varchar2(10)      ,/* 紀念日回饋條件 */
mmbr008       number(5,0)      ,/* 紀念日前(日) */
mmbr009       number(5,0)      ,/* 紀念日後(日) */
mmbr010       varchar2(10)      ,/* 回饋類型 */
mmbr011       number(5,0)      ,/* 加送倍數 */
mmbr012       number(20,6)      ,/* 回饋基點基準 */
mmbr013       number(15,3)      ,/* 加送積點 */
mmbr014       date      ,/* 開始日期 */
mmbr015       date      ,/* 結束日期 */
mmbr016       varchar2(8)      ,/* 每日開始時間 */
mmbr017       varchar2(8)      ,/* 每日結束時間 */
mmbr018       varchar2(10)      ,/* 固定日期 */
mmbr019       varchar2(10)      ,/* 固定星期 */
mmbracti       varchar2(1)      ,/* 資料有效 */
mmbrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbr_t add constraint mmbr_pk primary key (mmbrent,mmbrdocno,mmbr003,mmbr004) enable validate;

create unique index mmbr_pk on mmbr_t (mmbrent,mmbrdocno,mmbr003,mmbr004);

grant select on mmbr_t to tiptop;
grant update on mmbr_t to tiptop;
grant delete on mmbr_t to tiptop;
grant insert on mmbr_t to tiptop;

exit;
