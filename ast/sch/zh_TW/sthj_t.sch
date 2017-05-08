/* 
================================================================================
檔案代號:sthj_t
檔案名稱:費用標準位置設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sthj_t
(
sthjent       number(5)      ,/* 企業編號 */
sthjsite       varchar2(10)      ,/* 營運組織 */
sthjunit       varchar2(10)      ,/* 制定組織 */
sthjseq       number(10,0)      ,/* 項次 */
sthj001       varchar2(20)      ,/* 方案編號 */
sthj002       varchar2(10)      ,/* 樓棟編號 */
sthj003       varchar2(10)      ,/* 樓層編號 */
sthj004       varchar2(10)      ,/* 區域編號 */
sthj005       varchar2(10)      ,/* 品類編號 */
sthj006       varchar2(10)      ,/* 鋪位用途 */
sthj007       varchar2(20)      ,/* 鋪位編號 */
sthj008       varchar2(10)      ,/* 費用週期 */
sthj009       number(10,0)      ,/* 週期數值 */
sthj010       varchar2(10)      ,/* 計算類型 */
sthj011       varchar2(10)      ,/* 計算方式 */
sthjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sthjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sthjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sthjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sthjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sthjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sthjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sthjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sthjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sthjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sthjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sthjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sthjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sthjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sthjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sthjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sthjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sthjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sthjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sthjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sthjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sthjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sthjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sthjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sthjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sthjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sthjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sthjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sthjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sthjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sthj_t add constraint sthj_pk primary key (sthjent,sthjseq,sthj001) enable validate;

create unique index sthj_pk on sthj_t (sthjent,sthjseq,sthj001);

grant select on sthj_t to tiptop;
grant update on sthj_t to tiptop;
grant delete on sthj_t to tiptop;
grant insert on sthj_t to tiptop;

exit;
