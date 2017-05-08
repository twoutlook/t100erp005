/* 
================================================================================
檔案代號:stak_t
檔案名稱:自營合約異動申請單費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stak_t
(
stakent       number(5)      ,/* 企業編號 */
stakunit       varchar2(10)      ,/* 應用組織 */
staksite       varchar2(10)      ,/* 營運據點 */
stakdocno       varchar2(20)      ,/* 單號 */
stakseq       number(10,0)      ,/* 項次 */
stak003       varchar2(10)      ,/* 費用編號 */
stak004       varchar2(10)      ,/* 會計期間 */
stak005       varchar2(10)      ,/* 價款類別 */
stak006       varchar2(10)      ,/* 計算類型 */
stak007       varchar2(10)      ,/* 費用週期 */
stak008       varchar2(10)      ,/* 費用週期方式 */
stak009       varchar2(10)      ,/* 條件基準 */
stak010       varchar2(10)      ,/* 計算基準 */
stak011       number(20,6)      ,/* 費用淨額 */
stak012       number(20,6)      ,/* 費用比率 */
stak013       varchar2(10)      ,/* 保底否 */
stak014       number(20,6)      ,/* 保底金額 */
stak015       number(20,6)      ,/* 保底扣率 */
stak016       varchar2(10)      ,/* 分量扣點 */
stak017       date      ,/* 生效日期 */
stak018       date      ,/* 失效日期 */
stak019       date      ,/* 下次計算日 */
stakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stakud011       number(20,6)      ,/* 自定義欄位(文字)011 */
stakud012       number(20,6)      ,/* 自定義欄位(文字)012 */
stakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stakud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stak020       date      ,/* 下次費用開始日 */
stak021       date      ,/* 下次費用截止日 */
stak022       varchar2(10)      ,/* 自定義範圍 */
stak023       varchar2(1)      ,/* 納入結算單否 */
stak024       varchar2(1)      ,/* 票扣否 */
stak025       varchar2(10)      ,/* 管理品類 */
stak026       varchar2(20)      ,/* 生效月份 */
stak027       varchar2(1)      ,/* 按自然月計費否 */
stakacti       varchar2(1)      ,/* 有效 */
stak028       varchar2(1)      ,/* 固定費用是否按法人收取 */
stak029       number(20,6)      ,/* 促銷扣率 */
stak030       number(20,6)      /* 促銷銷售額占比 */
);
alter table stak_t add constraint stak_pk primary key (stakent,stakdocno,stakseq) enable validate;

create unique index stak_pk on stak_t (stakent,stakdocno,stakseq);

grant select on stak_t to tiptop;
grant update on stak_t to tiptop;
grant delete on stak_t to tiptop;
grant insert on stak_t to tiptop;

exit;
