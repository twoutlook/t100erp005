/* 
================================================================================
檔案代號:stcy_t
檔案名稱:市場推廣申請費用明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcy_t
(
stcyent       number(5)      ,/* 企業編號 */
stcyunit       varchar2(10)      ,/* 應用組織 */
stcysite       varchar2(10)      ,/* 營運據點 */
stcydocno       varchar2(20)      ,/* 單據編號 */
stcyseq       number(10,0)      ,/* 項次 */
stcy001       varchar2(10)      ,/* 對象類型 */
stcy002       varchar2(10)      ,/* 經銷商 */
stcy003       varchar2(10)      ,/* 網點編號 */
stcy004       varchar2(10)      ,/* 費用編號 */
stcy005       varchar2(10)      ,/* 價款類型 */
stcy006       varchar2(10)      ,/* 幣別 */
stcy007       varchar2(10)      ,/* 稅別 */
stcy008       number(20,6)      ,/* 申請金額 */
stcy009       date      ,/* 起始日期 */
stcy010       date      ,/* 截止日期 */
stcy011       number(10,0)      ,/* 結算會計期 */
stcy012       varchar2(20)      ,/* 合約編號 */
stcy013       varchar2(10)      ,/* 經營方式 */
stcy014       varchar2(10)      ,/* 結算方式 */
stcy015       varchar2(10)      ,/* 結算類型 */
stcy016       varchar2(10)      ,/* 結算中心 */
stcy017       varchar2(30)      ,/* 促銷方案 */
stcy018       varchar2(10)      ,/* 銷售範圍 */
stcy019       varchar2(10)      ,/* 銷售組織 */
stcy020       varchar2(10)      ,/* 銷售渠道 */
stcy021       varchar2(10)      ,/* 產品組 */
stcy022       varchar2(10)      ,/* 辦事處 */
stcy023       varchar2(80)      ,/* 備註 */
stcyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcy_t add constraint stcy_pk primary key (stcyent,stcydocno,stcyseq) enable validate;

create unique index stcy_pk on stcy_t (stcyent,stcydocno,stcyseq);

grant select on stcy_t to tiptop;
grant update on stcy_t to tiptop;
grant delete on stcy_t to tiptop;
grant insert on stcy_t to tiptop;

exit;
