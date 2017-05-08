/* 
================================================================================
檔案代號:glad_t
檔案名稱:帳別科目管理設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glad_t
(
gladent       number(5)      ,/* 企業編號 */
gladownid       varchar2(20)      ,/* 資料所有者 */
gladowndp       varchar2(10)      ,/* 資料所屬部門 */
gladcrtid       varchar2(20)      ,/* 資料建立者 */
gladcrtdp       varchar2(10)      ,/* 資料建立部門 */
gladcrtdt       timestamp(0)      ,/* 資料創建日 */
gladmodid       varchar2(20)      ,/* 資料修改者 */
gladmoddt       timestamp(0)      ,/* 最近修改日 */
gladstus       varchar2(10)      ,/* 狀態碼 */
gladld       varchar2(5)      ,/* 帳別 */
glad001       varchar2(24)      ,/* 會計科目編號 */
glad002       varchar2(1)      ,/* 是否按餘額類型產生分錄 */
glad003       varchar2(1)      ,/* 啟用傳票項次細項立沖 */
glad004       varchar2(1)      ,/* 傳票項次異動別 */
glad005       varchar2(1)      ,/* 是否啟用數量金額式 */
glad006       varchar2(10)      ,/* 借方現金變動碼 */
glad007       varchar2(1)      ,/* 啟用部門管理 */
glad008       varchar2(1)      ,/* 啟用利潤成本管理 */
glad009       varchar2(1)      ,/* 啟用區域管理 */
glad010       varchar2(1)      ,/* 啟用交易客商管理 */
glad011       varchar2(1)      ,/* 啟用客群管理 */
glad012       varchar2(1)      ,/* 啟用產品類別管理 */
glad013       varchar2(1)      ,/* 啟用人員管理 */
glad014       varchar2(1)      ,/* no use */
glad015       varchar2(1)      ,/* 啟用專案管理 */
glad016       varchar2(1)      ,/* 啟用WBS管理 */
glad017       varchar2(1)      ,/* 啟用自由核算項一 */
glad0171       varchar2(10)      ,/* 自由核算項一類型編號 */
glad0172       varchar2(1)      ,/* 自由核算項一控制方式 */
glad018       varchar2(1)      ,/* 啟用自由核算項二 */
glad0181       varchar2(10)      ,/* 自由核算項二類型編號 */
glad0182       varchar2(1)      ,/* 自由核算項二控制方式 */
glad019       varchar2(1)      ,/* 啟用自由核算項三 */
glad0191       varchar2(10)      ,/* 自由核算項三類型編號 */
glad0192       varchar2(1)      ,/* 自由核算項三控制方式 */
glad020       varchar2(1)      ,/* 啟用自由核算項四 */
glad0201       varchar2(10)      ,/* 自由核算項四類型編號 */
glad0202       varchar2(1)      ,/* 自由核算項四控制方式 */
glad021       varchar2(1)      ,/* 啟用自由核算項五 */
glad0211       varchar2(10)      ,/* 自由核算項五類型編號 */
glad0212       varchar2(1)      ,/* 自由核算項五控制方式 */
glad022       varchar2(1)      ,/* 啟用自由核算項六 */
glad0221       varchar2(10)      ,/* 自由核算項六類型編號 */
glad0222       varchar2(1)      ,/* 自由核算項六控制方式 */
glad023       varchar2(1)      ,/* 啟用自由核算項七 */
glad0231       varchar2(10)      ,/* 自由核算項七類型編號 */
glad0232       varchar2(1)      ,/* 自由核算項七控制方式 */
glad024       varchar2(1)      ,/* 啟用自由核算項八 */
glad0241       varchar2(10)      ,/* 自由核算項八類型編號 */
glad0242       varchar2(1)      ,/* 自由核算項八控制方式 */
glad025       varchar2(1)      ,/* 啟用自由核算項九 */
glad0251       varchar2(10)      ,/* 自由核算項九類型編號 */
glad0252       varchar2(1)      ,/* 自由核算項九控制方式 */
glad026       varchar2(1)      ,/* 啟用自由核算項十 */
glad0261       varchar2(10)      ,/* 自由核算項十類型編號 */
glad0262       varchar2(1)      ,/* 自由核算項十控制方式 */
glad027       varchar2(1)      ,/* 啟用帳款客商管理 */
glad030       varchar2(1)      ,/* 是否進行預算管控 */
glad031       varchar2(1)      ,/* 啟用經營方式管理 */
glad032       varchar2(1)      ,/* 啟用渠道管理 */
glad033       varchar2(1)      ,/* 啟用品牌管理 */
glad034       varchar2(1)      ,/* 科目做多幣別管理 */
gladud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gladud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gladud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gladud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gladud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gladud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gladud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gladud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gladud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gladud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gladud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gladud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gladud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gladud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gladud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gladud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gladud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gladud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gladud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gladud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gladud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gladud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gladud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gladud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gladud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gladud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gladud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gladud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gladud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gladud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glad035       varchar2(1)      ,/* 是否是子系統科目 */
glad036       varchar2(10)      /* 貸方現金變動碼 */
);
alter table glad_t add constraint glad_pk primary key (gladent,gladld,glad001) enable validate;

create unique index glad_pk on glad_t (gladent,gladld,glad001);

grant select on glad_t to tiptop;
grant update on glad_t to tiptop;
grant delete on glad_t to tiptop;
grant insert on glad_t to tiptop;

exit;
